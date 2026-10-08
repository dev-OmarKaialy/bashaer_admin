import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/emoji_catalog.dart';
import '../../../../core/widgets/category_icon.dart';

/// Grid of icons: emoji for new picks, plus the Font Awesome names seeded
/// categories already use. Resolves to the chosen value, or null.
Future<String?> showIconPickerDialog(BuildContext context, {String? current}) {
  return showDialog<String>(
    context: context,
    builder: (context) => _IconPickerDialog(current: current),
  );
}

class _IconPickerDialog extends StatelessWidget {
  const _IconPickerDialog({this.current});

  final String? current;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 600),
        child: DefaultTabController(
          length: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppTheme.spacingXL,
                  AppTheme.spacingL,
                  AppTheme.spacingS,
                  0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'categories.pickIcon'.tr(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    IconButton(
                      tooltip: 'common.close'.tr(),
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              TabBar(
                tabs: [
                  Tab(text: 'categories.iconTabs.emoji'.tr()),
                  Tab(text: 'categories.iconTabs.legacy'.tr()),
                ],
              ),
              Flexible(
                child: TabBarView(
                  children: [
                    ListView(
                      padding: const EdgeInsets.all(AppTheme.spacingL),
                      children: [
                        for (final group in EmojiCatalog.groups) ...[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: AppTheme.spacingS,
                              bottom: AppTheme.spacingS,
                            ),
                            child: Text(
                              'categories.iconGroups.${group.key}'.tr(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          _IconGrid(values: group.emoji, current: current),
                        ],
                      ],
                    ),
                    ListView(
                      padding: const EdgeInsets.all(AppTheme.spacingL),
                      children: [
                        Text(
                          'categories.legacyHint'.tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: AppTheme.inkSoft),
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        _IconGrid(values: EmojiCatalog.legacyNames, current: current),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconGrid extends StatelessWidget {
  const _IconGrid({required this.values, this.current});

  final List<String> values;
  final String? current;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppTheme.spacingS,
      runSpacing: AppTheme.spacingS,
      children: [
        for (final value in values)
          Tooltip(
            message: value,
            child: Material(
              color: value == current
                  ? AppTheme.nitroBlue.withValues(alpha: 0.12)
                  : AppTheme.skyBackground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
                side: BorderSide(color: value == current ? AppTheme.nitroBlue : AppTheme.divider),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
                onTap: () => Navigator.of(context).pop(value),
                child: SizedBox.square(
                  dimension: 52,
                  child: Center(
                    child: CategoryIcon(name: value, size: 24, color: AppTheme.ink),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
