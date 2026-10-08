import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'confirm_dialog.dart';

/// List and detail side by side on wide screens (list on the reading-start
/// side), list only on narrow ones. On narrow screens the caller pushes the
/// detail as a route instead.
class MasterDetailLayout extends StatelessWidget {
  const MasterDetailLayout({super.key, required this.list, required this.detail});

  final Widget list;

  /// The detail pane (the open editor, or a [DetailPlaceholder]). Only built
  /// on wide screens.
  final Widget detail;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < AdminTokens.twoPaneBreakpoint) return list;
    final listWidth = (width * 0.38).clamp(340.0, 480.0);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: listWidth, child: list),
        const VerticalDivider(width: 1),
        Expanded(child: detail),
      ],
    );
  }
}

/// What the detail pane shows before anything is selected.
class DetailPlaceholder extends StatelessWidget {
  const DetailPlaceholder({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: AppTheme.divider),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.inkFaint),
          ),
        ],
      ),
    );
  }
}

/// Selection for a [MasterDetailLayout] screen, owned by its State.
///
/// On wide screens [open] selects into the pane (asking first when the open
/// editor has unsaved changes); on narrow screens it pushes [pageBuilder].
class MasterDetailController {
  /// Id used to open an empty "new item" editor.
  static const String newItemId = '+new';

  final ValueNotifier<String?> selected = ValueNotifier<String?>(null);

  /// Reported by the pane editor; checked before switching rows.
  final ValueNotifier<bool> editorDirty = ValueNotifier<bool>(false);

  Future<void> open(BuildContext context, String id, {required WidgetBuilder pageBuilder}) async {
    if (MediaQuery.sizeOf(context).width >= AdminTokens.twoPaneBreakpoint) {
      if (selected.value == id) return;
      if (editorDirty.value) {
        final discard = await confirmDiscardChanges(context);
        if (!discard) return;
      }
      editorDirty.value = false;
      selected.value = id;
      return;
    }
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: pageBuilder));
  }

  void close() {
    editorDirty.value = false;
    selected.value = null;
  }

  void dispose() {
    selected.dispose();
    editorDirty.dispose();
  }
}
