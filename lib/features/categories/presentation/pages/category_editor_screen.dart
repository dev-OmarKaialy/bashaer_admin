import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependencies.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/admin/confirm_dialog.dart';
import '../../../../core/widgets/admin/editor_scaffold.dart';
import '../../../../core/widgets/admin/id_text.dart';
import '../../../../core/widgets/admin/master_detail_layout.dart';
import '../../../../core/widgets/admin/panel_card.dart';
import '../../../../core/widgets/category_icon.dart';
import '../../../questions/presentation/cubit/questions_cubit.dart';
import '../../../shell/presentation/cubit/shell_cubit.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/category_editor_cubit.dart';
import '../widgets/category_preview_card.dart';
import '../widgets/icon_picker_dialog.dart';

/// Phone route around [CategoryEditorView].
class CategoryEditorScreen extends StatelessWidget {
  const CategoryEditorScreen({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) => CategoryEditorView(slug: slug, isPane: false);
}

/// Create ([slug] = [MasterDetailController.newItemId]) or edit a category.
class CategoryEditorView extends StatelessWidget {
  const CategoryEditorView({
    super.key,
    required this.slug,
    required this.isPane,
    this.onClose,
    this.onSelect,
    this.onDirtyChanged,
  });

  final String slug;
  final bool isPane;
  final VoidCallback? onClose;

  /// Pane only: select another row (the new category after creating it).
  final ValueChanged<String>? onSelect;
  final ValueChanged<bool>? onDirtyChanged;

  bool get _isNew => slug == MasterDetailController.newItemId;

  void _close(BuildContext context) {
    if (isPane) {
      onClose?.call();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isNew) return _buildEditor(context);
    // Right after a create, the listener may not have delivered the new row
    // yet: wait for it instead of opening an empty "new" form.
    return BlocSelector<CategoriesCubit, CategoriesState, bool>(
      selector: (state) => state.bySlug(slug) != null,
      builder: (context, exists) {
        if (exists) return _buildEditor(context);
        const body = Center(child: CircularProgressIndicator());
        return isPane ? body : Scaffold(appBar: AppBar(), body: body);
      },
    );
  }

  Widget _buildEditor(BuildContext context) {
    final categories = context.read<CategoriesCubit>().state;
    return BlocProvider(
      create: (_) =>
          getIt<CategoryEditorCubit>()
            ..open(_isNew ? null : categories.bySlug(slug), nextOrder: categories.nextOrder),
      child: MultiBlocListener(
        listeners: [
          BlocListener<CategoryEditorCubit, CategoryEditorState>(
            listenWhen: (previous, current) => previous.isDirty != current.isDirty,
            listener: (context, state) => onDirtyChanged?.call(state.isDirty),
          ),
          BlocListener<CategoryEditorCubit, CategoryEditorState>(
            listenWhen: (previous, current) =>
                current.lastOutcome != null && previous.lastOutcome != current.lastOutcome,
            listener: (context, state) {
              final outcome = state.lastOutcome!;
              if (outcome.errorKey != null) {
                Toaster.showError(outcome.errorKey!.tr(namedArgs: outcome.errorArgs));
                return;
              }
              if (outcome.action == CategoryEditorAction.delete) {
                Toaster.showSuccess('categories.toast.deleted'.tr());
                onDirtyChanged?.call(false);
                _close(context);
                return;
              }
              Toaster.showSuccess(
                _isNew ? 'categories.toast.created'.tr() : 'categories.toast.saved'.tr(),
              );
              if (_isNew) {
                onDirtyChanged?.call(false);
                if (isPane) {
                  onSelect?.call(state.original!.slug);
                } else {
                  Navigator.of(context).maybePop();
                }
              }
            },
          ),
        ],
        child: _CategoryEditorFrame(isPane: isPane, onClose: onClose),
      ),
    );
  }
}

class _CategoryEditorFrame extends StatelessWidget {
  const _CategoryEditorFrame({required this.isPane, this.onClose});

  final bool isPane;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryEditorCubit, CategoryEditorState>(
      buildWhen: (previous, current) =>
          previous.isDirty != current.isDirty ||
          previous.isNew != current.isNew ||
          previous.submitStatus != current.submitStatus ||
          previous.original?.name != current.original?.name,
      builder: (context, state) {
        final cubit = context.read<CategoryEditorCubit>();
        return EditorScaffold(
          isPane: isPane,
          onClose: onClose,
          title: state.isNew ? 'categories.newTitle'.tr() : state.original!.name,
          subtitle: state.isNew ? null : IdText(id: state.original!.slug),
          isDirty: state.isDirty,
          isSaving: state.submitStatus.isLoading,
          onSave: state.isDirty ? cubit.save : null,
          aside: const _PreviewAside(),
          children: [
            const _BasicsSection(),
            const _IconSection(),
            if (!state.isNew) const _DangerSection(),
          ],
        );
      },
    );
  }
}

class _BasicsSection extends StatefulWidget {
  const _BasicsSection();

  @override
  State<_BasicsSection> createState() => _BasicsSectionState();
}

class _BasicsSectionState extends State<_BasicsSection> {
  late final CategoryEditorState _initial = context.read<CategoryEditorCubit>().state;
  late final _name = TextEditingController(text: _initial.name);
  late final _slug = TextEditingController(text: _initial.slug);
  late final _description = TextEditingController(text: _initial.description);

  @override
  void dispose() {
    _name.dispose();
    _slug.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CategoryEditorCubit>();
    return SectionCard(
      title: 'categories.basicsSection'.tr(),
      icon: Icons.edit_note_rounded,
      child: BlocBuilder<CategoryEditorCubit, CategoryEditorState>(
        buildWhen: (previous, current) =>
            previous.errors != current.errors || previous.isNew != current.isNew,
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _name,
              autofocus: state.isNew,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'categories.name'.tr(),
                errorText: state.errors['name']?.tr(),
              ),
              onChanged: cubit.setName,
            ),
            const SizedBox(height: AppTheme.spacingM),
            TextField(
              controller: _slug,
              enabled: state.isNew,
              textDirection: TextDirection.ltr,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'categories.slug'.tr(),
                hintText: 'traffic-signs',
                helperText: state.isNew
                    ? 'categories.slugHelpNew'.tr()
                    : 'categories.slugHelpLocked'.tr(),
                helperMaxLines: 2,
                errorText: state.errors['slug']?.tr(),
                prefixIcon: const Icon(Icons.link_rounded),
              ),
              onChanged: cubit.setSlug,
            ),
            const SizedBox(height: AppTheme.spacingM),
            TextField(
              controller: _description,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(labelText: 'categories.description'.tr()),
              onChanged: cubit.setDescription,
            ),
          ],
        ),
      ),
    );
  }
}

class _IconSection extends StatelessWidget {
  const _IconSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CategoryEditorCubit, CategoryEditorState, String?>(
      selector: (state) => state.icon,
      builder: (context, icon) {
        final cubit = context.read<CategoryEditorCubit>();
        return SectionCard(
          title: 'categories.iconSection'.tr(),
          icon: Icons.emoji_symbols_rounded,
          child: Row(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: AppTheme.oceanGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: SizedBox.square(
                  dimension: 64,
                  child: Center(
                    child: CategoryIcon(name: icon, size: 28, color: AppTheme.onPrimaryColor),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacingL),
              Expanded(
                child: Wrap(
                  spacing: AppTheme.spacingS,
                  runSpacing: AppTheme.spacingS,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () async {
                        final picked = await showIconPickerDialog(context, current: icon);
                        if (picked != null) cubit.setIcon(picked);
                      },
                      icon: const Icon(Icons.grid_view_rounded),
                      label: Text('categories.chooseIcon'.tr()),
                    ),
                    if (icon != null)
                      TextButton(
                        onPressed: () => cubit.setIcon(null),
                        child: Text('categories.clearIcon'.tr()),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DangerSection extends StatelessWidget {
  const _DangerSection();

  @override
  Widget build(BuildContext context) {
    final slug = context.read<CategoryEditorCubit>().state.original!.slug;
    return BlocSelector<QuestionsCubit, QuestionsState, int?>(
      selector: (state) => state.status.isSuccess ? (state.countsByCategory[slug] ?? 0) : null,
      builder: (context, count) {
        final blocked = count == null || count > 0;
        final textTheme = Theme.of(context).textTheme;
        return PanelCard(
          borderColor: AppTheme.dangerColor.withValues(alpha: 0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'categories.deleteSection'.tr(),
                style: textTheme.titleLarge?.copyWith(color: AppTheme.dangerColor),
              ),
              const SizedBox(height: AppTheme.spacingS),
              if (count != null && count > 0) ...[
                Text(
                  'categories.errors.notEmpty'.tr(namedArgs: {'count': '$count'}),
                  style: textTheme.bodyMedium?.copyWith(color: AppTheme.inkSoft),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: () {
                      context.read<QuestionsCubit>().showCategory(slug);
                      context.read<ShellCubit>().select(AdminTab.questions);
                      if (Navigator.of(context).canPop()) Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.quiz_outlined),
                    label: Text('categories.showQuestions'.tr()),
                  ),
                ),
              ] else
                Text(
                  'categories.deleteHint'.tr(),
                  style: textTheme.bodyMedium?.copyWith(color: AppTheme.inkSoft),
                ),
              const SizedBox(height: AppTheme.spacingS),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: BlocSelector<CategoryEditorCubit, CategoryEditorState, bool>(
                  selector: (state) => state.deleteStatus.isLoading,
                  builder: (context, deleting) => OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.dangerColor,
                      side: const BorderSide(color: AppTheme.dangerColor),
                    ),
                    onPressed: blocked || deleting
                        ? null
                        : () async {
                            final cubit = context.read<CategoryEditorCubit>();
                            final confirmed = await showConfirmDialog(
                              context,
                              title: 'categories.deleteTitle'.tr(),
                              message: 'categories.deleteMessage'.tr(),
                              confirmLabel: 'categories.delete'.tr(),
                              destructive: true,
                            );
                            if (confirmed) await cubit.delete();
                          },
                    icon: deleting
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline_rounded),
                    label: Text('categories.delete'.tr()),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PreviewAside extends StatelessWidget {
  const _PreviewAside();

  @override
  Widget build(BuildContext context) {
    final categories = context.read<CategoriesCubit>().state.categories;
    return BlocBuilder<CategoryEditorCubit, CategoryEditorState>(
      buildWhen: (previous, current) =>
          previous.name != current.name || previous.icon != current.icon,
      builder: (context, state) {
        final slug = state.original?.slug;
        final index = slug == null
            ? categories.length
            : categories.indexWhere((c) => c.slug == slug).clamp(0, categories.length);
        return BlocSelector<QuestionsCubit, QuestionsState, int>(
          selector: (questions) => slug == null ? 0 : (questions.countsByCategory[slug] ?? 0),
          builder: (context, count) =>
              CategoryPreviewCard(category: state.preview, index: index, questionCount: count),
        );
      },
    );
  }
}
