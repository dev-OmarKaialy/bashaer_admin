import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/unified_api/error/failure.dart';
import '../../../../core/utils/license_dates.dart';
import '../../../../core/utils/request_status.dart';
import '../../data/models/license_model.dart';
import '../../data/models/license_status.dart';
import '../../domain/usecases/get_license_usecase.dart';
import '../../domain/usecases/update_license_access_usecase.dart';
import '../../domain/usecases/update_license_profile_usecase.dart';

part 'license_editor_cubit.freezed.dart';
part 'license_editor_state.dart';

/// One open license: live row, access period draft, profile draft.
@injectable
class LicenseEditorCubit extends Cubit<LicenseEditorState> {
  LicenseEditorCubit(this._getLicense, this._updateAccess, this._updateProfile)
    : super(const LicenseEditorState());

  final GetLicenseUsecase _getLicense;
  final UpdateLicenseAccessUsecase _updateAccess;
  final UpdateLicenseProfileUsecase _updateProfile;

  StreamSubscription<Either<Failure, LicenseModel?>>? _subscription;
  String? _deviceId;
  int _seq = 0;

  /// Set while a profile save is in flight: the saved (normalized) values
  /// replace the draft when the listener reports them.
  bool _resyncProfile = false;

  /// Preset chosen by default for rows without current access.
  static const int defaultPreset = 3;

  void open(String deviceId) {
    _deviceId = deviceId;
    emit(state.copyWith(loadStatus: RequestStatus.loading));
    _subscription = _getLicense(deviceId).listen(_onLicense);
  }

  void _onLicense(Either<Failure, LicenseModel?> result) {
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(loadStatus: RequestStatus.failed, loadErrorKey: failure.message)),
      (license) {
        if (license == null) {
          emit(state.copyWith(loadStatus: RequestStatus.failed, loadErrorKey: 'errors.notFound'));
          return;
        }
        final first = state.license == null;
        var next = state.copyWith(license: license, loadStatus: RequestStatus.success);
        if (first || !state.isProfileDirty || _resyncProfile) {
          _resyncProfile = false;
          next = next.copyWith(
            fullName: license.fullName ?? '',
            phoneNumber: license.phoneNumber ?? '',
            note: license.note ?? '',
            formVersion: state.formVersion + 1,
          );
        }
        if (first) {
          final status = statusOf(license, DateTime.now());
          final hasAccess = status == LicenseStatus.active || status == LicenseStatus.expiring;
          if (!hasAccess) {
            next = next.copyWith(
              selectedPreset: defaultPreset,
              draftUntil: _presetUntil(license, defaultPreset),
            );
          }
        }
        emit(next);
      },
    );
  }

  DateTime _presetUntil(LicenseModel license, int months) {
    final status = statusOf(license, DateTime.now());
    // A revoked row restarts from today; others continue from their end date.
    final current = status == LicenseStatus.revoked ? null : license.activeUntil;
    return LicenseDates.presetUntil(now: DateTime.now(), currentUntil: current, months: months);
  }

  void selectPreset(int months) {
    final license = state.license;
    if (license == null) return;
    emit(state.copyWith(selectedPreset: months, draftUntil: _presetUntil(license, months)));
  }

  void pickDate(DateTime day) {
    emit(state.copyWith(selectedPreset: null, draftUntil: LicenseDates.endOfLocalDay(day)));
  }

  void setFullName(String value) => emit(state.copyWith(fullName: value));

  void setPhoneNumber(String value) => emit(state.copyWith(phoneNumber: value));

  void setNote(String value) => emit(state.copyWith(note: value));

  /// Approve, extend, renew or restore until [LicenseEditorState.draftUntil].
  Future<void> grant() async {
    final until = state.draftUntil;
    final license = state.license;
    if (until == null || license == null || state.accessStatus.isLoading) return;
    final action = statusOf(license, DateTime.now()) == LicenseStatus.revoked
        ? LicenseEditorAction.restore
        : LicenseEditorAction.grant;
    await _writeAccess(UpdateLicenseAccessParams.grant(deviceId: _deviceId!, until: until), action);
  }

  Future<void> revoke() async {
    final license = state.license;
    if (license == null || state.accessStatus.isLoading) return;
    await _writeAccess(
      UpdateLicenseAccessParams.revoke(deviceId: _deviceId!),
      LicenseEditorAction.revoke,
      undoUntil: license.activeUntil,
    );
  }

  /// Undo of a revoke: back to active with the previous end date.
  Future<void> undoRevoke(DateTime until) async {
    if (state.accessStatus.isLoading) return;
    await _writeAccess(
      UpdateLicenseAccessParams.grant(deviceId: _deviceId!, until: until),
      LicenseEditorAction.restore,
    );
  }

  Future<void> _writeAccess(
    UpdateLicenseAccessParams params,
    LicenseEditorAction action, {
    DateTime? undoUntil,
  }) async {
    emit(state.copyWith(accessStatus: RequestStatus.loading));
    final result = await _updateAccess(params);
    if (isClosed) return;
    result.fold(
      (failure) => emit(
        state.copyWith(
          accessStatus: RequestStatus.failed,
          lastOutcome: LicenseEditorOutcome(seq: ++_seq, action: action, errorKey: failure.message),
        ),
      ),
      (_) => emit(
        state.copyWith(
          accessStatus: RequestStatus.success,
          selectedPreset: null,
          draftUntil: null,
          lastOutcome: LicenseEditorOutcome(seq: ++_seq, action: action, undoUntil: undoUntil),
        ),
      ),
    );
  }

  Future<void> saveProfile() async {
    if (!state.isProfileDirty || state.profileStatus.isLoading) return;
    emit(state.copyWith(profileStatus: RequestStatus.loading));
    _resyncProfile = true;
    final result = await _updateProfile(
      UpdateLicenseProfileParams(
        deviceId: _deviceId!,
        fullName: state.fullName,
        phoneNumber: state.phoneNumber,
        note: state.note,
      ),
    );
    if (isClosed) return;
    result.fold(
      (failure) {
        _resyncProfile = false;
        emit(
          state.copyWith(
            profileStatus: RequestStatus.failed,
            lastOutcome: LicenseEditorOutcome(
              seq: ++_seq,
              action: LicenseEditorAction.profile,
              errorKey: failure.message,
            ),
          ),
        );
      },
      (_) => emit(
        state.copyWith(
          profileStatus: RequestStatus.success,
          lastOutcome: LicenseEditorOutcome(seq: ++_seq, action: LicenseEditorAction.profile),
        ),
      ),
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
