import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';
import '../../data/models/question_model.dart';
import '../cubit/questions_cubit.dart';

/// Category and type menus, "with image" and "trial" toggles, and a clear
/// button, in one horizontally scrollable row.
class QuestionFiltersBar extends StatelessWidget {
  const QuestionFiltersBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<QuestionsCubit, QuestionsState, QuestionFilters>(
      selector: (state) => state.filters,
      builder: (context, filters) {
        final cubit = context.read<QuestionsCubit>();
        return SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
            children: [
              Center(child: _CategoryMenu(selected: filters.categorySlug)),
              const SizedBox(width: AppTheme.spacingS),
              Center(child: _TypeMenu(selected: filters.type)),
              const SizedBox(width: AppTheme.spacingS),
              Center(
                child: FilterChip(
                  label: Text('questions.filters.withImage'.tr()),
                  avatar: const Icon(Icons.image_outlined, size: 16),
                  selected: filters.withImageOnly,
                  showCheckmark: false,
                  onSelected: (_) => cubit.toggleWithImage(),
                ),
              ),
              const SizedBox(width: AppTheme.spacingS),
              Center(
                child: FilterChip(
                  label: Text('questions.filters.trial'.tr()),
                  avatar: const Icon(Icons.card_giftcard_rounded, size: 16),
                  selected: filters.trialOnly,
                  showCheckmark: false,
                  onSelected: (_) => cubit.toggleTrial(),
                ),
              ),
              if (filters.categorySlug != null ||
                  filters.type != null ||
                  filters.withImageOnly ||
                  filters.trialOnly) ...[
                const SizedBox(width: AppTheme.spacingS),
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      cubit
                        ..setCategory(null)
                        ..setType(null);
                      if (filters.withImageOnly) cubit.toggleWithImage();
                      if (filters.trialOnly) cubit.toggleTrial();
                    },
                    icon: const Icon(Icons.filter_alt_off_outlined, size: 18),
                    label: Text('questions.filters.clear'.tr()),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _CategoryMenu extends StatelessWidget {
  const _CategoryMenu({required this.selected});

  final String? selected;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CategoriesCubit>().state;
    final label = selected == null
        ? 'questions.filters.allCategories'.tr()
        : (state.bySlug(selected!)?.name ?? selected!);
    // '' stands for "all": a null value would close the menu as a cancel.
    return PopupMenuButton<String>(
      tooltip: 'questions.filters.category'.tr(),
      onSelected: (slug) => context.read<QuestionsCubit>().setCategory(slug.isEmpty ? null : slug),
      itemBuilder: (context) => [
        PopupMenuItem<String>(value: '', child: Text('questions.filters.allCategories'.tr())),
        for (final category in state.categories)
          PopupMenuItem<String>(value: category.slug, child: Text(category.name)),
      ],
      child: _MenuChip(label: label, icon: Icons.category_outlined, active: selected != null),
    );
  }
}

class _TypeMenu extends StatelessWidget {
  const _TypeMenu({required this.selected});

  final QuestionType? selected;

  @override
  Widget build(BuildContext context) {
    // '' stands for "all" (see _CategoryMenu).
    return PopupMenuButton<String>(
      tooltip: 'questions.filters.type'.tr(),
      onSelected: (name) => context.read<QuestionsCubit>().setType(
        QuestionType.values.where((type) => type.name == name).firstOrNull,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<String>(value: '', child: Text('questions.filters.allTypes'.tr())),
        for (final type in QuestionType.values)
          PopupMenuItem<String>(value: type.name, child: Text('questions.types.${type.name}'.tr())),
      ],
      child: _MenuChip(
        label: selected == null
            ? 'questions.filters.allTypes'.tr()
            : 'questions.types.${selected!.name}'.tr(),
        icon: Icons.tune_rounded,
        active: selected != null,
      ),
    );
  }
}

class _MenuChip extends StatelessWidget {
  const _MenuChip({required this.label, required this.icon, required this.active});

  final String label;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppTheme.nitroBlue : AppTheme.ink;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: active ? AppTheme.nitroBlue.withValues(alpha: 0.12) : AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(AppTheme.radiusPill),
        border: Border.all(color: active ? AppTheme.nitroBlue : AppTheme.divider),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color)),
            Icon(Icons.arrow_drop_down_rounded, color: color),
          ],
        ),
      ),
    );
  }
}
