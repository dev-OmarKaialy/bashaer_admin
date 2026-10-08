import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'motion.dart';

/// "Nothing here yet" with an optional primary action. Empty is not an error.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.actionLabel,
    this.actionIcon,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? message;
  final String? actionLabel;
  final IconData? actionIcon;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXXL),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Entrance(
            scale: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppTheme.nitroBlue.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingXL),
                    child: Icon(icon, size: 40, color: AppTheme.nitroBlue),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingL),
                Text(title, textAlign: TextAlign.center, style: textTheme.titleLarge),
                if (message != null) ...[
                  const SizedBox(height: AppTheme.spacingS),
                  Text(
                    message!,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(color: AppTheme.inkSoft),
                  ),
                ],
                if (actionLabel != null && onAction != null) ...[
                  const SizedBox(height: AppTheme.spacingXL),
                  FilledButton.icon(
                    onPressed: onAction,
                    icon: Icon(actionIcon ?? Icons.add_rounded),
                    label: Text(actionLabel!),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A recoverable error with a retry button. [message] is already translated.
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXXL),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Entrance(
            scale: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_off_rounded, size: 48, color: AppTheme.dangerColor),
                const SizedBox(height: AppTheme.spacingM),
                Text('common.errorTitle'.tr(), style: textTheme.titleLarge),
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(color: AppTheme.inkSoft),
                ),
                if (onRetry != null) ...[
                  const SizedBox(height: AppTheme.spacingL),
                  OutlinedButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: Text('common.retry'.tr()),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Thin banner above data that is still shown after a refresh failed.
class InlineErrorBanner extends StatelessWidget {
  const InlineErrorBanner({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.dangerBackgroundColor,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppTheme.spacingL,
          AppTheme.spacingXS,
          AppTheme.spacingXS,
          AppTheme.spacingXS,
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline_rounded, size: 18, color: AppTheme.dangerColor),
            const SizedBox(width: AppTheme.spacingS),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.dangerColor),
              ),
            ),
            if (onRetry != null) TextButton(onPressed: onRetry, child: Text('common.retry'.tr())),
          ],
        ),
      ),
    );
  }
}
