import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/admin/id_text.dart';
import '../../../../core/widgets/category_icon.dart';
import '../../data/models/category_model.dart';

/// One category in the reorderable list: drag handle, icon badge, name, slug
/// and question count.
class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.category,
    required this.index,
    required this.questionCount,
    required this.selected,
    required this.onOpen,
  });

  final CategoryModel category;
  final int index;
  final int? questionCount;
  final bool selected;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final gradient = AppTheme.accentGradientAt(index);
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: selected ? AdminTokens.selectedRow : AppTheme.cardSurface,
      child: InkWell(
        onTap: onOpen,
        hoverColor: AdminTokens.hoverRow,
        child: SizedBox(
          height: AdminTokens.categoryRowExtent,
          child: Row(
            children: [
              ReorderableDragStartListener(
                index: index,
                child: Tooltip(
                  message: 'categories.dragHint'.tr(),
                  child: const MouseRegion(
                    cursor: SystemMouseCursors.grab,
                    child: SizedBox(
                      width: 44,
                      height: 48,
                      child: Icon(Icons.drag_indicator_rounded, color: AppTheme.inkFaint),
                    ),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusS),
                ),
                child: SizedBox.square(
                  dimension: 44,
                  child: Center(
                    child: CategoryIcon(
                      name: category.icon,
                      size: 20,
                      color: AppTheme.onPrimaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                    IdText(id: category.slug, copyable: false, size: 12),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: AppTheme.spacingL),
                child: Text(
                  questionCount == null
                      ? ''
                      : 'categories.questionCount'.tr(namedArgs: {'count': '$questionCount'}),
                  style: textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
