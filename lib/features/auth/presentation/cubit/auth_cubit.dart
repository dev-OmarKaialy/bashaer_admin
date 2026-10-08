import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/request_status.dart';
import '../../data/models/admin_session_model.dart';
import '../../domain/usecases/get_admin_session_usecase.dart';
import '../../domain/usecases/submit_sign_in_usecase.dart';
import '../../domain/usecases/submit_sign_out_usecase.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

/// App-wide session: decides between the sign-in screen and the admin shell.
/// Accounts live in the Firestore `admins` collection (no Firebase Auth).
@lazySingleton
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._getSession, this._signIn, this._signOut) : super(const AuthState());

  final GetAdminSessionUsecase _getSession;
  final SubmitSignInUsecase _signIn;
  final SubmitSignOutUsecase _signOut;

  /// Restores the session remembered on this device (called once at start).
  Future<void> restore() async {
    final result = await _getSession(const NoParams());
    if (isClosed) return;
    result.fold(
      // Offline or unreadable: ask for the password rather than guess.
      (_) => emit(state.copyWith(status: AuthStatus.signedOut)),
      (session) => session == null
          ? emit(state.copyWith(status: AuthStatus.signedOut))
          : _emitAdmin(session),
    );
  }

  Future<void> signIn({required String username, required String password}) async {
    if (state.signInStatus.isLoading) return;
    emit(state.copyWith(signInStatus: RequestStatus.loading, errorKey: null));
    final result = await _signIn(SubmitSignInParams(username: username, password: password));
    if (isClosed) return;
    result.fold(
      (failure) =>
          emit(state.copyWith(signInStatus: RequestStatus.failed, errorKey: failure.message)),
      _emitAdmin,
    );
  }

  void _emitAdmin(AdminSessionModel session) {
    emit(
      state.copyWith(
        status: AuthStatus.admin,
        username: session.username,
        displayName: session.displayName,
        signInStatus: RequestStatus.success,
        errorKey: null,
      ),
    );
  }

  Future<void> signOut() async {
    await _signOut(const NoParams());
    if (isClosed) return;
    emit(const AuthState(status: AuthStatus.signedOut));
  }
}
