import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/widgets/admin/admin_search_field.dart';
import '../../../../core/widgets/admin/list_header.dart';
import '../../../../core/widgets/admin/master_detail_layout.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../../core/widgets/admin/skeleton_list.dart';
import '../../../../core/widgets/admin/state_views.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';
import '../cubit/questions_cubit.dart';
import '../widgets/question_filters_bar.dart';
import '../widgets/question_row.dart';
import 'question_editor_screen.dart';

/// Questions tab: filters, search, the bank in numeric qid order, and the
/// editor beside the list on wide screens.
class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final _controller = MasterDetailController();
  final _searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<QuestionsCubit>().start();
    context.read<CategoriesCubit>().start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _open(String id) {
    _controller.open(context, id, pageBuilder: (_) => QuestionEditorScreen(id: id));
  }

  void _create() {
    final filters = context.read<QuestionsCubit>().state.filters;
    _open(QuestionEditorView.newId(categorySlug: filters.categorySlug, type: filters.type));
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.slash): _searchFocus.requestFocus,
        const SingleActivator(LogicalKeyboardKey.keyN, control: true): _create,
      },
      child: MasterDetailLayout(
        list: ColoredBox(
          color: AppTheme.cardSurface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListHeader(
                title: 'questions.title'.tr(),
                actions: [
                  const _QuestionsCount(),
                  const SizedBox(width: AppTheme.spacingS),
                  FilledButton.icon(
                    onPressed: _create,
                    icon: const Icon(Icons.add_rounded),
                    label: Text('questions.new'.tr()),
                  ),
                ],
                search: AdminSearchField(
                  hint: 'questions.searchHint'.tr(),
                  focusNode: _searchFocus,
                  initialValue: context.read<QuestionsCubit>().state.filters.query,
                  onChanged: context.read<QuestionsCubit>().setQuery,
                ),
                filters: const QuestionFiltersBar(),
              ),
              Expanded(
                child: _QuestionsList(controller: _controller, onOpen: _open, onCreate: _create),
              ),
            ],
          ),
        ),
        detail: ValueListenableBuilder<String?>(
          valueListenable: _controller.selected,
          builder: (context, id, _) => FadeThroughSwitcher(
            child: id == null
                ? DetailPlaceholder(icon: Icons.quiz_outlined, message: 'questions.selectHint'.tr())
                : QuestionEditorView(
                    key: ValueKey(id),
                    id: id,
                    isPane: true,
                    onClose: _controller.close,
                    onSelect: (next) {
                      _controller.editorDirty.value = false;
                      _controller.selected.value = next;
                    },
                    onDirtyChanged: (dirty) => _controller.editorDirty.value = dirty,
                  ),
          ),
        ),
      ),
    );
  }
}

class _QuestionsCount extends StatelessWidget {
  const _QuestionsCount();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<QuestionsCubit, QuestionsState, (int, int)>(
      selector: (state) => (state.visible.length, state.all.length),
      builder: (context, counts) {
        final (visible, total) = counts;
        if (total == 0) return const SizedBox.shrink();
        return Text(
          visible == total
              ? 'questions.count'.tr(namedArgs: {'count': '$total'})
              : 'questions.countFiltered'.tr(namedArgs: {'visible': '$visible', 'total': '$total'}),
          style: Theme.of(context).textTheme.bodySmall,
        );
      },
    );
  }
}

class _QuestionsList extends StatelessWidget {
  const _QuestionsList({required this.controller, required this.onOpen, required this.onCreate});

  final MasterDetailController controller;
  final ValueChanged<String> onOpen;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.visible != current.visible ||
          previous.all.isEmpty != current.all.isEmpty,
      builder: (context, state) {
        final cubit = context.read<QuestionsCubit>();
        final view = state.all.isEmpty
            ? (state.status.isInit || state.status.isLoading
                  ? 'loading'
                  : state.status.isFailed
                  ? 'error'
                  : 'empty')
            : state.visible.isEmpty
            ? 'no-matches'
            : 'data';
        // Skeleton → list → empty states cross-fade instead of popping.
        return FadeThroughSwitcher(
          child: KeyedSubtree(
            key: ValueKey(view),
            child: Builder(
              builder: (context) {
                if (state.all.isEmpty) {
                  if (state.status.isInit || state.status.isLoading) {
                    return const SkeletonList(itemExtent: AdminTokens.questionRowExtent);
                  }
                  if (state.status.isFailed) {
                    return ErrorState(
                      message: (state.errorKey ?? 'errors.unknown').tr(),
                      onRetry: cubit.retry,
                    );
                  }
                  return EmptyState(
                    icon: Icons.quiz_outlined,
                    title: 'questions.empty'.tr(),
                    actionLabel: 'questions.new'.tr(),
                    onAction: onCreate,
                  );
                }
                if (state.visible.isEmpty) {
                  return EmptyState(
                    icon: Icons.search_off_rounded,
                    title: state.filters.query.isEmpty
                        ? 'questions.noMatches'.tr()
                        : 'common.noResults'.tr(namedArgs: {'query': state.filters.query}),
                    actionLabel: 'questions.filters.clearAll'.tr(),
                    actionIcon: Icons.filter_alt_off_outlined,
                    onAction: cubit.clearFilters,
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (state.status.isFailed)
                      InlineErrorBanner(
                        message: (state.errorKey ?? 'errors.unknown').tr(),
                        onRetry: cubit.retry,
                      ),
                    Expanded(
                      child: BlocBuilder<CategoriesCubit, CategoriesState>(
                        buildWhen: (previous, current) => previous.categories != current.categories,
                        builder: (context, categories) => StaggerScope(
                          replayKey: state.filters,
                          child: ListView.builder(
                            itemExtent: AdminTokens.questionRowExtent,
                            itemCount: state.visible.length,
                            itemBuilder: (context, index) {
                              final question = state.visible[index];
                              return StaggeredItem(
                                key: ValueKey(question.qid),
                                index: index,
                                child: ValueListenableBuilder<String?>(
                                  valueListenable: controller.selected,
                                  builder: (context, selected, _) => QuestionRow(
                                    question: question,
                                    categoryName: categories.bySlug(question.categorySlug)?.name,
                                    selected: selected == question.qid,
                                    onOpen: () => onOpen(question.qid),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
