import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Short, non-blocking feedback at the top of the screen.
///
/// Success toasts close quickly; errors stay longer. Pass [actionLabel] and
/// [onAction] for an undoable action ("تراجع"); the toast then stays 5 s.
class Toaster {
  Toaster._();

  static void showToast(
    String text, {
    bool isError = true,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final hasAction = actionLabel != null && onAction != null;
    final color = isError ? AppTheme.dangerColor : AppTheme.successColor;
    BotToast.showCustomText(
      align: const Alignment(0, -0.92),
      onlyOne: true,
      clickClose: false,
      crossPage: true,
      duration: hasAction
          ? const Duration(seconds: 5)
          : isError
          ? const Duration(seconds: 5)
          : const Duration(milliseconds: 2200),
      animationDuration: const Duration(milliseconds: 180),
      animationReverseDuration: const Duration(milliseconds: 140),
      toastBuilder: (cancel) => _ToastCard(
        text: text,
        color: color,
        icon: isError ? Icons.error_outline_rounded : Icons.check_circle_rounded,
        actionLabel: actionLabel,
        onAction: hasAction
            ? () {
                cancel();
                onAction();
              }
            : null,
        onClose: cancel,
      ),
    );
  }

  static void showSuccess(String text, {String? actionLabel, VoidCallback? onAction}) =>
      showToast(text, isError: false, actionLabel: actionLabel, onAction: onAction);

  static void showError(String text) => showToast(text);
}

class _ToastCard extends StatelessWidget {
  const _ToastCard({
    required this.text,
    required this.color,
    required this.icon,
    required this.onClose,
    this.actionLabel,
    this.onAction,
  });

  final String text;
  final Color color;
  final IconData icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 480),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
        child: Material(
          color: AppTheme.cardSurface,
          elevation: AppTheme.elevationL,
          shadowColor: AppTheme.ink.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusM),
            side: BorderSide(color: color.withValues(alpha: 0.35)),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppTheme.spacingL,
              AppTheme.spacingS,
              AppTheme.spacingXS,
              AppTheme.spacingS,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 22),
                const SizedBox(width: AppTheme.spacingM),
                Flexible(
                  child: Text(
                    text,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                ),
                if (onAction != null) ...[
                  const SizedBox(width: AppTheme.spacingS),
                  TextButton(onPressed: onAction, child: Text(actionLabel!)),
                ] else
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close_rounded, size: 18),
                    color: AppTheme.inkSoft,
                    tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
