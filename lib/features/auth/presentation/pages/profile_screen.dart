import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/admin/confirm_dialog.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../../core/widgets/admin/panel_card.dart';
import '../cubit/auth_cubit.dart';

/// Profile tab: who is signed in, how the account is managed, and sign out.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.skyBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Align(
          alignment: AlignmentDirectional.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AdminTokens.formMaxWidth),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Entrance(scale: true, child: _IdentityCard()),
                SizedBox(height: AppTheme.spacingL),
                Entrance(index: 1, child: _AccountSection()),
                SizedBox(height: AppTheme.spacingL),
                Entrance(index: 2, child: _SignOutButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          previous.username != current.username || previous.displayName != current.displayName,
      builder: (context, state) {
        final username = state.username ?? '';
        final name = state.displayName ?? username;
        final initial = name.isEmpty ? '?' : name.characters.first.toUpperCase();
        final textTheme = Theme.of(context).textTheme;
        return DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppTheme.heroGradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingXXL),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppTheme.onPrimaryColor.withValues(alpha: 0.2),
                  child: Text(
                    initial,
                    style: textTheme.displaySmall?.copyWith(color: AppTheme.onPrimaryColor),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingM),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineMedium?.copyWith(color: AppTheme.onPrimaryColor),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    '@$username',
                    style: AppTheme.numberStyle(
                      15,
                      color: AppTheme.onPrimaryColor.withValues(alpha: 0.85),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingM),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppTheme.onPrimaryColor.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingM,
                      vertical: AppTheme.spacingXS,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.admin_panel_settings_rounded,
                          size: 16,
                          color: AppTheme.onPrimaryColor,
                        ),
                        const SizedBox(width: AppTheme.spacingXS),
                        Text(
                          'profile.role'.tr(),
                          style: textTheme.labelMedium?.copyWith(color: AppTheme.onPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AccountSection extends StatelessWidget {
  const _AccountSection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SectionCard(
      title: 'profile.accountSection'.tr(),
      icon: Icons.manage_accounts_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _InfoRow(
            icon: Icons.devices_rounded,
            title: 'profile.sessionTitle'.tr(),
            body: 'profile.sessionBody'.tr(),
          ),
          const Divider(height: AppTheme.spacingXL),
          _InfoRow(
            icon: Icons.password_rounded,
            title: 'profile.passwordTitle'.tr(),
            body: 'profile.passwordBody'.tr(),
          ),
          const SizedBox(height: AppTheme.spacingXS),
          Text(
            'fvm dart run tool/admin_password.dart',
            textDirection: TextDirection.ltr,
            style: textTheme.bodySmall?.copyWith(fontFamily: AppTheme.displayNumberFont),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppTheme.inkSoft, size: 22),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              const SizedBox(height: 2),
              Text(body, style: textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppTheme.dangerColor,
        side: const BorderSide(color: AppTheme.dangerColor),
      ),
      onPressed: () async {
        final confirmed = await showConfirmDialog(
          context,
          title: 'shell.signOutTitle'.tr(),
          message: 'shell.signOutMessage'.tr(),
          confirmLabel: 'shell.signOut'.tr(),
          icon: Icons.logout_rounded,
        );
        if (confirmed && context.mounted) await context.read<AuthCubit>().signOut();
      },
      icon: const Icon(Icons.logout_rounded),
      label: Text('shell.signOut'.tr()),
    );
  }
}
