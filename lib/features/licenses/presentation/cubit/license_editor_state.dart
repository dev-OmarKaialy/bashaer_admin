part of 'license_editor_cubit.dart';

enum LicenseEditorAction { grant, revoke, restore, profile }

/// Result of the last write, for the toast (and undo after revoke).
@freezed
abstract class LicenseEditorOutcome with _$LicenseEditorOutcome {
  const factory LicenseEditorOutcome({
    required int seq,
    required LicenseEditorAction action,
    String? errorKey,

    /// After a revoke: the end date to restore on undo.
    DateTime? undoUntil,
  }) = _LicenseEditorOutcome;
}

@freezed
abstract class LicenseEditorState with _$LicenseEditorState {
  const factory LicenseEditorState({
    @Default(RequestStatus.init) RequestStatus loadStatus,
    String? loadErrorKey,
    LicenseModel? license,

    /// Chosen end date for approve / extend (end of day, local).
    DateTime? draftUntil,

    /// The preset chip that produced [draftUntil], if any.
    int? selectedPreset,
    @Default('') String fullName,
    @Default('') String phoneNumber,
    @Default('') String note,

    /// Bumped when the profile draft is replaced from the server, so the
    /// text fields reload their controllers.
    @Default(0) int formVersion,
    @Default(RequestStatus.init) RequestStatus accessStatus,
    @Default(RequestStatus.init) RequestStatus profileStatus,
    LicenseEditorOutcome? lastOutcome,
  }) = _LicenseEditorState;

  const LicenseEditorState._();

  bool get isProfileDirty {
    final current = license;
    if (current == null) return false;
    return fullName.trim() != (current.fullName ?? '') ||
        phoneNumber.trim() != (current.phoneNumber ?? '') ||
        note.trim() != (current.note ?? '');
  }

  bool get isBusy => accessStatus.isLoading || profileStatus.isLoading;
}
