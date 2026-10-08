import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/admin/list_header.dart';
import '../../../../core/widgets/admin/master_detail_layout.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../../core/widgets/admin/skeleton_list.dart';
import '../../../../core/widgets/admin/state_views.dart';
import '../../../questions/presentation/cubit/questions_cubit.dart';
import '../cubit/categories_cubit.dart';
import '../widgets/category_row.dart';
import 'category_editor_screen.dart';

/// Categories tab: drag to reorder, create, edit, delete (blocked while the
/// category still has questions).
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _controller = MasterDetailController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().start();
    // Question counts per category come from the bank already in memory.
    context.read<QuestionsCubit>().start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _open(String slug) {
    _controller.open(context, slug, pageBuilder: (_) => CategoryEditorScreen(slug: slug));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesCubit, CategoriesState>(
      listenWhen: (previous, current) => previous.reorderSeq != current.reorderSeq,
      listener: (context, state) {
        if (state.reorderStatus.isFailed) {
          Toaster.showError((state.reorderErrorKey ?? 'errors.unknown').tr());
        } else {
          Toaster.showSuccess('categories.toast.reordered'.tr());
        }
      },
      child: MasterDetailLayout(
        list: ColoredBox(
          color: AppTheme.cardSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListHeader(
                title: 'categories.title'.tr(),
                actions: [
                  FilledButton.icon(
                    onPressed: () => _open(MasterDetailController.newItemId),
                    icon: const Icon(Icons.add_rounded),
                    label: Text('categories.new'.tr()),
                  ),
                ],
              ),
              Expanded(
                child: _CategoriesList(
                  controller: _controller,
                  onOpen: _open,
                  onCreate: () => _open(MasterDetailController.newItemId),
                ),
              ),
            ],
          ),
        ),
        detail: ValueListenableBuilder<String?>(
          valueListenable: _controller.selected,
          builder: (context, slug, _) => FadeThroughSwitcher(
            child: slug == null
                ? DetailPlaceholder(
                    icon: Icons.category_outlined,
                    message: 'categories.selectHint'.tr(),
                  )
                : CategoryEditorView(
                    key: ValueKey(slug),
                    slug: slug,
                    isPane: true,
                    onClose: _controller.close,
                    onSelect: (next) => _controller.selected.value = next,
                    onDirtyChanged: (dirty) => _controller.editorDirty.value = dirty,
                  ),
          ),
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList({required this.controller, required this.onOpen, required this.onCreate});

  final MasterDetailController controller;
  final ValueChanged<String> onOpen;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) =>
          previous.status != current.status || previous.categories != current.categories,
      builder: (context, state) {
        final cubit = context.read<CategoriesCubit>();
        final view = state.categories.isNotEmpty
            ? 'data'
            : state.status.isInit || state.status.isLoading
            ? 'loading'
            : state.status.isFailed
            ? 'error'
            : 'empty';
        // Skeleton → list → empty states cross-fade instead of popping.
        return FadeThroughSwitcher(
          child: KeyedSubtree(
            key: ValueKey(view),
            child: Builder(
              builder: (context) {
                if (state.categories.isEmpty) {
                  if (state.status.isInit || state.status.isLoading) {
                    return const SkeletonList(itemExtent: AdminTokens.categoryRowExtent);
                  }
                  if (state.status.isFailed) {
                    return ErrorState(
                      message: (state.errorKey ?? 'errors.unknown').tr(),
                      onRetry: cubit.retry,
                    );
                  }
                  return EmptyState(
                    icon: Icons.category_outlined,
                    title: 'categories.empty'.tr(),
                    actionLabel: 'categories.new'.tr(),
                    onAction: onCreate,
                  );
                }
                return StaggerScope(
                  child: ReorderableListView.builder(
                    buildDefaultDragHandles: false,
                    // The dragged row lifts off the list.
                    proxyDecorator: (child, index, animation) => AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        final t = Curves.easeOut.transform(animation.value);
                        return Transform.scale(
                          scale: 1 + 0.02 * t,
                          child: Material(
                            elevation: AppTheme.elevationL * t,
                            shadowColor: AppTheme.ink.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(AppTheme.radiusS),
                            child: child,
                          ),
                        );
                      },
                      child: child,
                    ),
                    itemExtent: AdminTokens.categoryRowExtent,
                    itemCount: state.categories.length,
                    onReorderItem: cubit.moveItem,
                    itemBuilder: (context, index) {
                      final category = state.categories[index];
                      return StaggeredItem(
                        key: ValueKey(category.slug),
                        index: index,
                        child: ValueListenableBuilder<String?>(
                          valueListenable: controller.selected,
                          builder: (context, selected, _) =>
                              BlocSelector<QuestionsCubit, QuestionsState, int?>(
                                selector: (questions) => questions.status.isSuccess
                                    ? (questions.countsByCategory[category.slug] ?? 0)
                                    : null,
                                builder: (context, count) => CategoryRow(
                                  category: category,
                                  index: index,
                                  questionCount: count,
                                  selected: selected == category.slug,
                                  onOpen: () => onOpen(category.slug),
                                ),
                              ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
