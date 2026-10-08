part of 'licenses_cubit.dart';

/// The chips above the list.
enum LicenseFilter { pending, active, expiring, expired, revoked }

extension LicenseFilterX on LicenseFilter {
  /// Filters backed by their own Firestore query (the rest come from the inbox).
  LicenseQueryFilter? get queryFilter => switch (this) {
    LicenseFilter.active => LicenseQueryFilter.active,
    LicenseFilter.expiring => LicenseQueryFilter.expiring,
    LicenseFilter.expired => LicenseQueryFilter.expired,
    LicenseFilter.pending || LicenseFilter.revoked => null,
  };
}

/// A row as the list shows it: the license plus its status, computed once
/// when the list is built (not in `build()`).
@freezed
abstract class LicenseListItem with _$LicenseListItem {
  const factory LicenseListItem({required LicenseModel license, required LicenseStatus status}) =
      _LicenseListItem;
}

@freezed
abstract class LicensePageState with _$LicensePageState {
  const factory LicensePageState({
    @Default(<LicenseModel>[]) List<LicenseModel> items,
    Object? cursor,
    @Default(true) bool hasMore,
    @Default(RequestStatus.init) RequestStatus status,
    String? errorKey,
  }) = _LicensePageState;
}

enum LicenseActionKind { granted, revoked, restored }

/// Result of a quick action, for the toast (with undo) shown by the screen.
@freezed
abstract class LicenseActionOutcome with _$LicenseActionOutcome {
  const factory LicenseActionOutcome({
    required int seq,
    required String deviceId,
    required LicenseActionKind kind,
    DateTime? until,
    String? errorKey,
  }) = _LicenseActionOutcome;
}

@freezed
abstract class LicensesState with _$LicensesState {
  const factory LicensesState({
    @Default(RequestStatus.init) RequestStatus inboxStatus,
    String? inboxErrorKey,
    @Default(<LicenseModel>[]) List<LicenseModel> inbox,
    @Default(LicenseFilter.pending) LicenseFilter filter,
    @Default(<LicenseQueryFilter, LicensePageState>{})
    Map<LicenseQueryFilter, LicensePageState> pages,
    @Default(<LicenseFilter, int>{}) Map<LicenseFilter, int> counts,
    @Default('') String query,
    @Default(RequestStatus.init) RequestStatus searchStatus,
    String? searchErrorKey,

    /// What the list renders, derived from the fields above.
    @Default(<LicenseListItem>[]) List<LicenseListItem> visible,

    /// Rows with a quick action in flight.
    @Default(<String>{}) Set<String> busyIds,
    LicenseActionOutcome? lastOutcome,
  }) = _LicensesState;

  const LicensesState._();

  int get pendingCount => counts[LicenseFilter.pending] ?? 0;

  bool get isSearching => query.trim().isNotEmpty;

  LicensePageState? get currentPage {
    final queryFilter = filter.queryFilter;
    return queryFilter == null ? null : pages[queryFilter];
  }
}
