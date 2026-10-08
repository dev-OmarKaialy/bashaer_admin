import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../theme/app_theme.dart';

/// Top of a list panel: title (on rail layouts; phones show it in the app
/// bar), primary actions, then search and filters.
class ListHeader extends StatelessWidget {
  const ListHeader({
    super.key,
    required this.title,
    this.actions = const [],
    this.search,
    this.filters,
  });

  final String title;
  final List<Widget> actions;
  final Widget? search;
  final Widget? filters;

  @override
  Widget build(BuildContext context) {
    final showTitle = context.useRail;
    return ColoredBox(
      color: AppTheme.cardSurface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showTitle || actions.isNotEmpty)
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppTheme.spacingL,
                AppTheme.spacingM,
                AppTheme.spacingS,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: showTitle
                        ? Text(title, style: Theme.of(context).textTheme.headlineMedium)
                        : const SizedBox.shrink(),
                  ),
                  ...actions,
                ],
              ),
            ),
          if (search != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingL,
                AppTheme.spacingM,
                AppTheme.spacingL,
                0,
              ),
              child: search,
            ),
          if (filters != null) ...[const SizedBox(height: AppTheme.spacingXS), filters!],
          const SizedBox(height: AppTheme.spacingXS),
          const Divider(),
        ],
      ),
    );
  }
}
