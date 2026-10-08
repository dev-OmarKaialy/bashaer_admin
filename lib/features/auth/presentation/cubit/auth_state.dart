part of 'auth_cubit.dart';

enum AuthStatus {
  /// Checking the session remembered on this device.
  unknown,
  signedOut,
  admin,
}

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
    String? username,
    String? displayName,
    @Default(RequestStatus.init) RequestStatus signInStatus,

    /// Translation key of the last sign-in error.
    String? errorKey,
  }) = _AuthState;
}
