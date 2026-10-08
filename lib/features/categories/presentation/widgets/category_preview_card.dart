import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/category_icon.dart';
import '../../../../core/widgets/race_card.dart';
import '../../data/models/category_model.dart';

/// The category tile as the students' categories screen draws it (same
/// gradient by position, same icon renderer), for a live preview.
class CategoryPreviewCard extends StatelessWidget {
  const CategoryPreviewCard({
    super.key,
    required this.category,
    required this.index,
    required this.questionCount,
  });

  final CategoryModel category;
  final int index;
  final int questionCount;

  @override
  Widget build(BuildContext context) {
    final gradient = AppTheme.accentGradientAt(index);
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('common.preview'.tr(), style: textTheme.labelMedium),
        const SizedBox(height: AppTheme.spacingS),
        RaceCard(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              GradientIconBadge(
                gradient: gradient,
                size: 56,
                child: CategoryIcon(name: category.icon, size: 24, color: AppTheme.onPrimaryColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.name.isEmpty ? 'categories.namePlaceholder'.tr() : category.name,
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    RaceTag(
                      label: 'categories.questionCount'.tr(namedArgs: {'count': '$questionCount'}),
                      color: gradient.colors.first,
                      icon: Icons.quiz_rounded,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              DecoratedBox(
                decoration: BoxDecoration(gradient: gradient, shape: BoxShape.circle),
                child: const SizedBox(
                  width: 44,
                  height: 44,
                  child: Icon(Icons.play_arrow_rounded, color: AppTheme.onPrimaryColor, size: 28),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
