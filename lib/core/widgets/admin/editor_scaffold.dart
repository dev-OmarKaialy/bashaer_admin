import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_theme.dart';
import 'confirm_dialog.dart';
import 'motion.dart';

/// Frame shared by every editor (license, category, question, plan).
///
/// - **Pane** ([isPane] true): header with title and save button, used inside
///   the detail pane of [MasterDetailLayout].
/// - **Page**: a full route with an app bar and a sticky save bar at the
///   bottom, used on phones.
///
/// Both support `Ctrl+S` to save and `Esc` to close, and the page asks before
/// discarding unsaved changes.
class EditorScaffold extends StatelessWidget {
  const EditorScaffold({
    super.key,
    required this.title,
    required this.children,
    required this.isPane,
    this.subtitle,
    this.onSave,
    this.isSaving = false,
    this.isDirty = false,
    this.saveLabel,
    this.onClose,
    this.menu,
    this.aside,
  });

  final String title;
  final Widget? subtitle;
  final List<Widget> children;
  final bool isPane;

  /// Null disables the save button (nothing to save, or invalid).
  final VoidCallback? onSave;
  final bool isSaving;
  final bool isDirty;
  final String? saveLabel;

  /// Pane only: closes the editor. Pages pop instead.
  final VoidCallback? onClose;

  /// Overflow actions (delete, revoke, ...).
  final Widget? menu;

  /// Side content (e.g. a live preview) shown next to the form when the
  /// editor itself is wide enough, and under it otherwise.
  final Widget? aside;

  void _save() {
    if (!isSaving) onSave?.call();
  }

  @override
  Widget build(BuildContext context) {
    final body = _EditorBody(aside: aside, children: children);
    final shortcuts = <ShortcutActivator, VoidCallback>{
      const SingleActivator(LogicalKeyboardKey.keyS, control: true): _save,
      const SingleActivator(LogicalKeyboardKey.keyS, meta: true): _save,
      if (isPane && onClose != null) const SingleActivator(LogicalKeyboardKey.escape): onClose!,
    };

    if (isPane) {
      return CallbackShortcuts(
        bindings: shortcuts,
        child: FocusScope(
          child: ColoredBox(
            color: AppTheme.skyBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PaneHeader(
                  title: title,
                  subtitle: subtitle,
                  menu: menu,
                  onClose: onClose,
                  saveButton: _SaveButton(
                    label: saveLabel,
                    isSaving: isSaving,
                    onPressed: onSave == null ? null : _save,
                  ),
                ),
                const Divider(),
                Expanded(child: body),
              ],
            ),
          ),
        ),
      );
    }

    return UnsavedChangesGuard(
      isDirty: isDirty && !isSaving,
      child: CallbackShortcuts(
        bindings: shortcuts,
        child: FocusScope(
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              actions: [?menu],
              bottom: subtitle == null
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(36),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                        child: subtitle,
                      ),
                    ),
            ),
            body: body,
            bottomNavigationBar: onSave == null && !isSaving
                ? null
                : _BottomSaveBar(
                    child: _SaveButton(
                      label: saveLabel,
                      isSaving: isSaving,
                      expand: true,
                      onPressed: onSave == null ? null : _save,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _EditorBody extends StatelessWidget {
  const _EditorBody({required this.children, this.aside});

  final List<Widget> children;
  final Widget? aside;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final sideBySide = aside != null && constraints.maxWidth >= 1000;
        final form = ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AdminTokens.editorMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) const SizedBox(height: AppTheme.spacingL),
                Entrance(index: i, child: children[i]),
              ],
              if (aside != null && !sideBySide) ...[
                const SizedBox(height: AppTheme.spacingL),
                Entrance(index: children.length, child: aside!),
              ],
            ],
          ),
        );
        return SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: sideBySide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(flex: 3, child: form),
                      const SizedBox(width: AppTheme.spacingL),
                      Flexible(
                        flex: 2,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Entrance(index: 2, offsetY: 0.03, child: aside!),
                        ),
                      ),
                    ],
                  )
                : form,
          ),
        );
      },
    );
  }
}

class _PaneHeader extends StatelessWidget {
  const _PaneHeader({
    required this.title,
    required this.saveButton,
    this.subtitle,
    this.menu,
    this.onClose,
  });

  final String title;
  final Widget? subtitle;
  final Widget saveButton;
  final Widget? menu;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppTheme.cardSurface,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppTheme.spacingL,
          AppTheme.spacingM,
          AppTheme.spacingS,
          AppTheme.spacingM,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (subtitle != null) ...[const SizedBox(height: 2), subtitle!],
                ],
              ),
            ),
            saveButton,
            ?menu,
            if (onClose != null)
              IconButton(
                tooltip: 'common.close'.tr(),
                icon: const Icon(Icons.close_rounded),
                onPressed: onClose,
              ),
          ],
        ),
      ),
    );
  }
}

class _BottomSaveBar extends StatelessWidget {
  const _BottomSaveBar({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppTheme.cardSurface,
        border: Border(top: BorderSide(color: AppTheme.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(padding: const EdgeInsets.all(AppTheme.spacingM), child: child),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({
    required this.isSaving,
    required this.onPressed,
    this.label,
    this.expand = false,
  });

  final bool isSaving;
  final VoidCallback? onPressed;
  final String? label;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton.icon(
      onPressed: isSaving ? null : onPressed,
      icon: isSaving
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.inkFaint),
            )
          : const Icon(Icons.check_rounded),
      label: Text(label ?? 'common.save'.tr()),
    );
    final tooltip = Tooltip(message: 'common.saveShortcut'.tr(), child: button);
    return expand ? SizedBox(width: double.infinity, child: tooltip) : tooltip;
  }
}
