import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../shell/presentation/pages/admin_shell.dart';
import '../cubit/auth_cubit.dart';
import 'sign_in_screen.dart';

/// Root of the app: the brand splash while the remembered session is checked,
/// then the sign-in screen or the admin shell.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, AuthStatus>(
      selector: (state) => state.status,
      builder: (context, status) {
        return FadeThroughSwitcher(
          child: switch (status) {
            AuthStatus.unknown => const _Splash(key: ValueKey('splash')),
            AuthStatus.admin => const AdminShell(key: ValueKey('shell')),
            AuthStatus.signedOut => const SignInScreen(key: ValueKey('sign-in')),
          },
        );
      },
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(gradient: AppTheme.heroGradient),
      child: Center(
        child: SizedBox.square(
          dimension: 28,
          child: CircularProgressIndicator(strokeWidth: 3, color: AppTheme.onPrimaryColor),
        ),
      ),
    );
  }
}
