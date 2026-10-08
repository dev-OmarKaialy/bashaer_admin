import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// Asks before a consequential action. The confirm button names the action
/// ("حذف السؤال"), never a bare "نعم". Resolves to true only on confirm.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
  IconData? icon,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => _ConfirmDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel,
      destructive: destructive,
      icon: icon ?? (destructive ? Icons.delete_outline_rounded : Icons.help_outline_rounded),
    ),
  );
  return result ?? false;
}

class _ConfirmDialog extends StatelessWidget {
  const _ConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.destructive,
    required this.icon,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final bool destructive;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppTheme.dangerColor : AppTheme.nitroBlue;
    return AlertDialog(
      icon: Icon(icon, color: color, size: 32),
      title: Text(title, textAlign: TextAlign.center),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.inkSoft),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('common.cancel'.tr()),
        ),
        FilledButton(
          autofocus: !destructive,
          style: FilledButton.styleFrom(backgroundColor: color),
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}

/// Blocks back navigation while [isDirty] and asks before discarding edits.
class UnsavedChangesGuard extends StatelessWidget {
  const UnsavedChangesGuard({super.key, required this.isDirty, required this.child});

  final bool isDirty;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isDirty,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final discard = await confirmDiscardChanges(context);
        if (discard && context.mounted) Navigator.of(context).pop();
      },
      child: child,
    );
  }
}

/// Shared "discard unsaved changes?" prompt.
Future<bool> confirmDiscardChanges(BuildContext context) {
  return showConfirmDialog(
    context,
    title: 'common.unsavedTitle'.tr(),
    message: 'common.unsavedMessage'.tr(),
    confirmLabel: 'common.discard'.tr(),
    destructive: true,
    icon: Icons.edit_off_rounded,
  );
}
