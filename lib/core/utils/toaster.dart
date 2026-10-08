import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Short, non-blocking feedback at the top of the screen.
///
/// Toasts are drawn by bot_toast above the Navigator, where there is no
/// `Overlay`: nothing inside may use a `Tooltip` (so no `IconButton`s).
///
/// Success toasts close quickly; errors stay longer. With [actionLabel] and
/// [onAction] ("تراجع") the toast stays 5 s and shows a countdown bar.
class Toaster {
  Toaster._();

  static const _short = Duration(milliseconds: 2400);
  static const _long = Duration(seconds: 5);

  static void showToast(
    String text, {
    bool isError = true,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final hasAction = actionLabel != null && onAction != null;
    final duration = hasAction || isError ? _long : _short;
    BotToast.showCustomText(
      align: const AlignmentDirectional(0, -0.94),
      onlyOne: true,
      crossPage: true,
      clickClose: false,
      useSafeArea: true,
      duration: duration,
      animationDuration: const Duration(milliseconds: 280),
      animationReverseDuration: const Duration(milliseconds: 180),
      wrapToastAnimation: (controller, cancel, child) =>
          _ToastTransition(animation: controller, child: child),
      toastBuilder: (cancel) => _ToastCard(
        text: text,
        isError: isError,
        duration: duration,
        actionLabel: hasAction ? actionLabel : null,
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

/// Drops in from the top with a slight scale, fades out on close.
class _ToastTransition extends StatelessWidget {
  const _ToastTransition({required this.animation, required this.child});

  final Animation<double> animation;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      return FadeTransition(opacity: animation, child: child);
    }
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutBack,
      reverseCurve: Curves.easeInCubic,
    );
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: SlideTransition(
        position: Tween(begin: const Offset(0, -0.6), end: Offset.zero).animate(curved),
        child: ScaleTransition(scale: Tween(begin: 0.94, end: 1.0).animate(curved), child: child),
      ),
    );
  }
}

class _ToastCard extends StatelessWidget {
  const _ToastCard({
    required this.text,
    required this.isError,
    required this.duration,
    required this.onClose,
    this.actionLabel,
    this.onAction,
  });

  final String text;
  final bool isError;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final color = isError ? AppTheme.dangerColor : AppTheme.successColor;
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 460),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
        child: Material(
          color: AppTheme.cardSurface,
          elevation: AppTheme.elevationL,
          shadowColor: AppTheme.ink.withValues(alpha: 0.18),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusM)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Colored edge on the reading-start side.
                    ColoredBox(color: color, child: const SizedBox(width: 4)),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                        AppTheme.spacingM,
                        AppTheme.spacingM,
                        AppTheme.spacingS,
                        AppTheme.spacingM,
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            isError ? Icons.priority_high_rounded : Icons.check_rounded,
                            color: color,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          widthFactor: 1,
                          child: Text(
                            text,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleSmall,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingS),
                    if (onAction != null)
                      Center(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(end: AppTheme.spacingS),
                          child: TextButton(onPressed: onAction, child: Text(actionLabel!)),
                        ),
                      )
                    else
                      _CloseButton(onTap: onClose),
                  ],
                ),
              ),
              if (onAction != null) _Countdown(duration: duration, color: color),
            ],
          ),
        ),
      ),
    );
  }
}

/// Close control without a Tooltip (no Overlay is available here).
class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: MaterialLocalizations.of(context).closeButtonLabel,
      child: InkResponse(
        onTap: onTap,
        radius: 20,
        child: const SizedBox(
          width: 44,
          child: Icon(Icons.close_rounded, size: 18, color: AppTheme.inkFaint),
        ),
      ),
    );
  }
}

/// Shrinking bar showing how long the undo action stays available.
class _Countdown extends StatelessWidget {
  const _Countdown({required this.duration, required this.color});

  final Duration duration;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: duration,
      builder: (context, value, _) => LinearProgressIndicator(
        value: value,
        minHeight: 3,
        color: color,
        backgroundColor: color.withValues(alpha: 0.12),
      ),
    );
  }
}
