import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../../core/widgets/admin/panel_card.dart';
import '../cubit/auth_cubit.dart';

/// Username + password sign-in against the Firestore `admins` collection.
/// No sign-up and no password reset: accounts are managed in the console
/// (see docs/admin-account.md).
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppTheme.heroGradient),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: const Entrance(
                  scale: true,
                  offsetY: 0.04,
                  child: PanelCard(
                    padding: EdgeInsets.all(AppTheme.spacingXXL),
                    child: _SignInForm(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  const _SignInForm();

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController(text: kDebugMode ? 'admin' : '');
  final _password = TextEditingController(text: kDebugMode ? 'admin123@' : '');
  final _passwordFocus = FocusNode();
  final _obscure = ValueNotifier<bool>(true);

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    _obscure.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    context.read<AuthCubit>().signIn(username: _username.text, password: _password.text);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusL),
                child: Image.asset('assets/icons/launcher_icon.png', width: 72, height: 72),
              ),
            ),
            const SizedBox(height: AppTheme.spacingL),
            Text('auth.title'.tr(), textAlign: TextAlign.center, style: textTheme.headlineMedium),
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              'auth.subtitle'.tr(),
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(color: AppTheme.inkSoft),
            ),
            const SizedBox(height: AppTheme.spacingXXL),
            TextFormField(
              controller: _username,
              keyboardType: TextInputType.visiblePassword,
              autocorrect: false,
              enableSuggestions: false,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.username],
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                labelText: 'auth.username'.tr(),
                prefixIcon: const Icon(Icons.person_outline_rounded),
              ),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'validation.required'.tr();
                return null;
              },
              onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
            ),
            const SizedBox(height: AppTheme.spacingM),
            ValueListenableBuilder<bool>(
              valueListenable: _obscure,
              builder: (context, obscure, _) => TextFormField(
                controller: _password,
                focusNode: _passwordFocus,
                obscureText: obscure,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                textDirection: TextDirection.ltr,
                decoration: InputDecoration(
                  labelText: 'auth.password'.tr(),
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    tooltip: obscure ? 'auth.showPassword'.tr() : 'auth.hidePassword'.tr(),
                    icon: Icon(obscure ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                    onPressed: () => _obscure.value = !obscure,
                  ),
                ),
                validator: (value) => (value ?? '').isEmpty ? 'validation.required'.tr() : null,
                onFieldSubmitted: (_) => _submit(),
              ),
            ),
            const _SignInError(),
            const SizedBox(height: AppTheme.spacingXL),
            BlocSelector<AuthCubit, AuthState, bool>(
              selector: (state) => state.signInStatus.isLoading,
              builder: (context, isLoading) => FilledButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text('auth.signIn'.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignInError extends StatelessWidget {
  const _SignInError();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, String?>(
      selector: (state) => state.signInStatus.isFailed ? state.errorKey : null,
      builder: (context, errorKey) {
        return AnimatedSize(
          duration: AdminTokens.fast,
          curve: AdminTokens.curve,
          child: errorKey == null
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(top: AppTheme.spacingM),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppTheme.dangerBackgroundColor,
                      borderRadius: BorderRadius.circular(AppTheme.radiusS),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            color: AppTheme.dangerColor,
                            size: 20,
                          ),
                          const SizedBox(width: AppTheme.spacingS),
                          Expanded(
                            child: Text(
                              errorKey.tr(),
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(color: AppTheme.dangerColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
