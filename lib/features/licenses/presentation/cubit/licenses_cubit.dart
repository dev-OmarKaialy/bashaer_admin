import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/arabic_normalizer.dart';
import '../../../../core/utils/request_status.dart';
import '../../data/models/license_model.dart';
import '../../data/models/license_status.dart';
import '../../domain/usecases/get_approved_licenses_usecase.dart';
import '../../domain/usecases/get_inbox_licenses_usecase.dart';
import '../../domain/usecases/get_license_by_id_usecase.dart';
import '../../domain/usecases/get_license_counts_usecase.dart';
import '../../domain/usecases/get_licenses_page_usecase.dart';
import '../../domain/usecases/update_license_access_usecase.dart';

part 'licenses_cubit.freezed.dart';
part 'licenses_state.dart';

/// The licenses tab: live inbox, filtered pages, counts, search and quick
/// approve. A singleton for the signed-in session, so switching tabs keeps
/// the listener (and its reads) instead of re-opening it.
@lazySingleton
class LicensesCubit extends Cubit<LicensesState> {
  LicensesCubit(
    this._getInbox,
    this._getPage,
    this._getCounts,
    this._getApproved,
    this._getById,
    this._updateAccess,
  ) : super(const LicensesState());

  final GetInboxLicensesUsecase _getInbox;
  final GetLicensesPageUsecase _getPage;
  final GetLicenseCountsUsecase _getCounts;
  final GetApprovedLicensesUsecase _getApproved;
  final GetLicenseByIdUsecase _getById;
  final UpdateLicenseAccessUsecase _updateAccess;

  StreamSubscription<Either<Failure, List<LicenseModel>>>? _inboxSubscription;

  /// Session cache for search: approved rows plus exact id lookups.
  Map<String, LicenseModel>? _searchCache;
  int _outcomeSeq = 0;
  int _searchToken = 0;
  Future<Either<Failure, List<LicenseModel>>>? _approvedRequest;

  static final RegExp _deviceIdPattern = RegExp(r'^[A-Za-z0-9_\-:.]{8,}$');

  /// Opens the inbox listener once per session.
  void start() {
    if (_inboxSubscription != null) return;
    emit(state.copyWith(inboxStatus: RequestStatus.loading));
    _inboxSubscription = _getInbox(const GetInboxLicensesParams()).listen(_onInbox);
    unawaited(_loadCounts());
  }

  /// Retry after the inbox listener failed.
  void retryInbox() {
    unawaited(_inboxSubscription?.cancel());
    _inboxSubscription = null;
    start();
  }

  /// Drops listeners and caches (sign-out).
  Future<void> reset() async {
    await _inboxSubscription?.cancel();
    _inboxSubscription = null;
    _searchCache = null;
    _approvedRequest = null;
    if (isClosed) return;
    emit(const LicensesState());
  }

  void _onInbox(Either<Failure, List<LicenseModel>> result) {
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(inboxStatus: RequestStatus.failed, inboxErrorKey: failure.message)),
      (inbox) {
        final now = DateTime.now();
        var pending = 0;
        var revoked = 0;
        for (final license in inbox) {
          if (statusOf(license, now) == LicenseStatus.revoked) {
            revoked++;
          } else {
            pending++;
          }
        }
        _emitDerived(
          state.copyWith(
            inbox: inbox,
            inboxStatus: RequestStatus.success,
            inboxErrorKey: null,
            counts: {
              ...state.counts,
              LicenseFilter.pending: pending,
              LicenseFilter.revoked: revoked,
            },
          ),
        );
      },
    );
  }

  Future<void> _loadCounts() async {
    final result = await _getCounts(DateTime.now());
    if (isClosed) return;
    result.fold((_) {}, (counts) {
      emit(
        state.copyWith(
          counts: {
            ...state.counts,
            LicenseFilter.active: counts[LicenseQueryFilter.active] ?? 0,
            LicenseFilter.expiring: counts[LicenseQueryFilter.expiring] ?? 0,
            LicenseFilter.expired: counts[LicenseQueryFilter.expired] ?? 0,
          },
        ),
      );
    });
  }

  void selectFilter(LicenseFilter filter) {
    if (filter == state.filter) return;
    _emitDerived(state.copyWith(filter: filter));
    final queryFilter = filter.queryFilter;
    if (queryFilter != null && (state.pages[queryFilter]?.status.isInit ?? true)) {
      unawaited(_loadPage(queryFilter, reset: true));
    }
  }

  /// Infinite scroll: next page of the current query filter.
  void loadMore() {
    final queryFilter = state.filter.queryFilter;
    if (queryFilter == null || state.isSearching) return;
    final page = state.pages[queryFilter];
    if (page == null || page.status.isLoading || !page.hasMore) return;
    unawaited(_loadPage(queryFilter));
  }

  /// Pull to refresh / retry for the current view.
  Future<void> refresh() async {
    final queryFilter = state.filter.queryFilter;
    await Future.wait([
      _loadCounts(),
      if (queryFilter != null) _loadPage(queryFilter, reset: true),
    ]);
  }

  Future<void> _loadPage(LicenseQueryFilter filter, {bool reset = false}) async {
    final previous = reset
        ? const LicensePageState()
        : (state.pages[filter] ?? const LicensePageState());
    _emitPage(filter, previous.copyWith(status: RequestStatus.loading, errorKey: null));
    final result = await _getPage(
      GetLicensesPageParams(filter: filter, now: DateTime.now(), cursor: previous.cursor),
    );
    if (isClosed) return;
    result.fold(
      (failure) => _emitPage(
        filter,
        previous.copyWith(status: RequestStatus.failed, errorKey: failure.message),
      ),
      (page) => _emitPage(
        filter,
        LicensePageState(
          items: [...previous.items, ...page.items],
          cursor: page.cursor,
          hasMore: page.hasMore,
          status: RequestStatus.success,
        ),
      ),
    );
  }

  void _emitPage(LicenseQueryFilter filter, LicensePageState page) {
    _emitDerived(state.copyWith(pages: {...state.pages, filter: page}));
  }

  /// Searches by device id, name, phone or note.
  Future<void> search(String query) async {
    final trimmed = query.trim();
    if (trimmed == state.query) return;
    final token = ++_searchToken;
    if (trimmed.isEmpty) {
      _emitDerived(state.copyWith(query: '', searchStatus: RequestStatus.init));
      return;
    }
    if (_searchCache == null) {
      emit(state.copyWith(query: trimmed, searchStatus: RequestStatus.loading));
      // Typing fast must not start a second full load.
      final result = await (_approvedRequest ??= _getApproved(const NoParams()));
      if (isClosed || token != _searchToken) return;
      final failed = result.fold(
        (failure) {
          _approvedRequest = null;
          emit(state.copyWith(searchStatus: RequestStatus.failed, searchErrorKey: failure.message));
          return true;
        },
        (approved) {
          _searchCache = {for (final license in approved) license.deviceId: license};
          return false;
        },
      );
      if (failed) return;
    }
    if (_deviceIdPattern.hasMatch(trimmed) && !_searchCache!.containsKey(trimmed)) {
      final lookup = await _getById(trimmed);
      if (isClosed || token != _searchToken) return;
      lookup.fold((_) {}, (license) {
        if (license != null) _searchCache![license.deviceId] = license;
      });
    }
    _emitDerived(state.copyWith(query: trimmed, searchStatus: RequestStatus.success));
  }

  /// Approve / extend / renew straight from the list.
  Future<void> quickGrant(LicenseModel license, DateTime until) async {
    if (state.busyIds.contains(license.deviceId)) return;
    final wasRevoked = statusOf(license, DateTime.now()) == LicenseStatus.revoked;
    emit(state.copyWith(busyIds: {...state.busyIds, license.deviceId}));
    final result = await _updateAccess(
      UpdateLicenseAccessParams.grant(deviceId: license.deviceId, until: until),
    );
    if (isClosed) return;
    final busy = {...state.busyIds}..remove(license.deviceId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          busyIds: busy,
          lastOutcome: LicenseActionOutcome(
            seq: ++_outcomeSeq,
            deviceId: license.deviceId,
            kind: LicenseActionKind.granted,
            errorKey: failure.message,
          ),
        ),
      ),
      (_) => emit(
        state.copyWith(
          busyIds: busy,
          lastOutcome: LicenseActionOutcome(
            seq: ++_outcomeSeq,
            deviceId: license.deviceId,
            kind: wasRevoked ? LicenseActionKind.restored : LicenseActionKind.granted,
            until: until,
          ),
        ),
      ),
    );
    await licenseChanged(license.deviceId);
  }

  /// Called after any write to a license (here or in its editor): refreshes
  /// counts, the open page and the search cache entry. The inbox listener
  /// updates itself.
  Future<void> licenseChanged(String deviceId) async {
    final queryFilter = state.filter.queryFilter;
    // Other pages are stale now; reload them when they are next opened.
    final pages = {
      for (final entry in state.pages.entries)
        if (entry.key == queryFilter) entry.key: entry.value,
    };
    emit(state.copyWith(pages: pages));
    final cache = _searchCache;
    await Future.wait([
      _loadCounts(),
      if (queryFilter != null) _loadPage(queryFilter, reset: true),
      if (cache != null)
        _getById(deviceId).then((result) {
          result.fold((_) {}, (license) {
            if (license == null || !license.isActive) {
              cache.remove(deviceId);
            } else {
              cache[deviceId] = license;
            }
          });
        }),
    ]);
    if (isClosed) return;
    if (state.isSearching) _emitDerived(state);
  }

  /// Rebuilds [LicensesState.visible] from the source fields.
  void _emitDerived(LicensesState next) {
    final now = DateTime.now();
    final List<LicenseModel> source;
    if (next.isSearching) {
      final needle = normalizeForSearch(next.query);
      final byId = <String, LicenseModel>{
        ...?_searchCache,
        for (final license in next.inbox) license.deviceId: license,
      };
      source = byId.values.where((license) => license.searchKey.contains(needle)).toList()
        ..sort(
          (a, b) => (b.updatedAt ?? b.createdAt ?? DateTime(0)).compareTo(
            a.updatedAt ?? a.createdAt ?? DateTime(0),
          ),
        );
    } else {
      final queryFilter = next.filter.queryFilter;
      if (queryFilter != null) {
        source = next.pages[queryFilter]?.items ?? const [];
      } else {
        final wanted = next.filter == LicenseFilter.revoked
            ? LicenseStatus.revoked
            : LicenseStatus.pending;
        source = next.inbox.where((license) => statusOf(license, now) == wanted).toList();
      }
    }
    emit(
      next.copyWith(
        visible: [
          for (final license in source)
            LicenseListItem(license: license, status: statusOf(license, now)),
        ],
      ),
    );
  }

  @override
  Future<void> close() async {
    await _inboxSubscription?.cancel();
    return super.close();
  }
}
