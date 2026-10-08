import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependencies.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/admin/confirm_dialog.dart';
import '../../../../core/widgets/admin/editor_scaffold.dart';
import '../../../../core/widgets/admin/master_detail_layout.dart';
import '../../../../core/widgets/admin/panel_card.dart';
import '../../../../core/widgets/admin/status_pill.dart';
import '../../../categories/presentation/cubit/categories_cubit.dart';
import '../../data/models/question_model.dart';
import '../cubit/question_editor_cubit.dart';
import '../cubit/questions_cubit.dart';
import '../widgets/answers_editor.dart';
import '../widgets/question_image_field.dart';
import '../widgets/quiz_preview.dart';

/// Phone route around [QuestionEditorView].
class QuestionEditorScreen extends StatelessWidget {
  const QuestionEditorScreen({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) => QuestionEditorView(id: id, isPane: false);
}

/// Create or edit one question, with a live preview.
///
/// [id] is a qid, or [newId] (optionally carrying a category and type to
/// preselect).
class QuestionEditorView extends StatelessWidget {
  const QuestionEditorView({
    super.key,
    required this.id,
    required this.isPane,
    this.onClose,
    this.onSelect,
    this.onDirtyChanged,
  });

  final String id;
  final bool isPane;
  final VoidCallback? onClose;

  /// Pane only: select another id (the created question, or a new draft).
  final ValueChanged<String>? onSelect;
  final ValueChanged<bool>? onDirtyChanged;

  static String newId({String? categorySlug, QuestionType? type}) =>
      '${MasterDetailController.newItemId}|${categorySlug ?? ''}|${type?.name ?? ''}';

  bool get _isNew => id.startsWith(MasterDetailController.newItemId);

  @override
  Widget build(BuildContext context) {
    if (_isNew) return _buildEditor(context, null);
    // Right after a create the listener may not have delivered the row yet.
    return BlocSelector<QuestionsCubit, QuestionsState, QuestionModel?>(
      selector: (state) => state.byQid(id),
      builder: (context, question) {
        if (question != null) return _buildEditor(context, question);
        const body = Center(child: CircularProgressIndicator());
        return isPane ? body : Scaffold(appBar: AppBar(), body: body);
      },
    );
  }

  Widget _buildEditor(BuildContext context, QuestionModel? question) {
    final parts = id.split('|');
    final presetCategory = parts.length > 1 && parts[1].isNotEmpty ? parts[1] : null;
    final presetType = parts.length > 2
        ? QuestionType.values.where((t) => t.name == parts[2]).firstOrNull
        : null;
    return BlocProvider(
      // Keyed by qid: later updates to the same question don't reset the form.
      key: ValueKey(question?.qid ?? id),
      create: (_) => getIt<QuestionEditorCubit>()
        ..open(
          question: question,
          existingQids: context.read<QuestionsCubit>().state.qids,
          categorySlugs: _slugs(context.read<CategoriesCubit>().state),
          categorySlug: presetCategory,
          type: presetType,
        ),
      child: MultiBlocListener(
        listeners: [
          BlocListener<CategoriesCubit, CategoriesState>(
            listenWhen: (previous, current) => previous.categories != current.categories,
            listener: (context, state) =>
                context.read<QuestionEditorCubit>().setCategorySlugs(_slugs(state)),
          ),
          BlocListener<QuestionEditorCubit, QuestionEditorState>(
            listenWhen: (previous, current) => previous.isDirty != current.isDirty,
            listener: (context, state) => onDirtyChanged?.call(state.isDirty),
          ),
          BlocListener<QuestionEditorCubit, QuestionEditorState>(
            listenWhen: (previous, current) =>
                current.lastOutcome != null && previous.lastOutcome != current.lastOutcome,
            listener: (context, state) => _onOutcome(context, state),
          ),
        ],
        child: _QuestionEditorFrame(isPane: isPane, onClose: onClose),
      ),
    );
  }

  static Set<String> _slugs(CategoriesState state) => {for (final c in state.categories) c.slug};

  void _onOutcome(BuildContext context, QuestionEditorState state) {
    final outcome = state.lastOutcome!;
    if (outcome.errorKey != null) {
      Toaster.showError(outcome.errorKey!.tr());
      return;
    }
    switch (outcome.action) {
      case QuestionEditorAction.image:
        return;
      case QuestionEditorAction.delete:
        Toaster.showSuccess('questions.toast.deleted'.tr());
        onDirtyChanged?.call(false);
        if (isPane) {
          onClose?.call();
        } else {
          Navigator.of(context).maybePop();
        }
      case QuestionEditorAction.save:
        final created = outcome.createdQid;
        if (created == null) {
          Toaster.showSuccess('questions.toast.saved'.tr());
          return;
        }
        final another = newId(categorySlug: state.draft.categorySlug, type: state.draft.type);
        final navigator = Navigator.of(context);
        Toaster.showSuccess(
          'questions.toast.created'.tr(namedArgs: {'qid': created}),
          actionLabel: 'questions.addAnother'.tr(),
          onAction: () {
            if (isPane) {
              onSelect?.call(another);
            } else {
              navigator.pushReplacement(
                MaterialPageRoute<void>(builder: (_) => QuestionEditorScreen(id: another)),
              );
            }
          },
        );
        onDirtyChanged?.call(false);
        if (isPane) onSelect?.call(created);
    }
  }
}

class _QuestionEditorFrame extends StatelessWidget {
  const _QuestionEditorFrame({required this.isPane, this.onClose});

  final bool isPane;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionEditorCubit, QuestionEditorState>(
      buildWhen: (previous, current) =>
          previous.isDirty != current.isDirty ||
          previous.isNew != current.isNew ||
          previous.submitStatus != current.submitStatus ||
          previous.isUploading != current.isUploading ||
          previous.original?.isTrial != current.original?.isTrial,
      builder: (context, state) {
        final cubit = context.read<QuestionEditorCubit>();
        final original = state.original;
        final isTrial = original?.isTrial ?? false;
        return EditorScaffold(
          isPane: isPane,
          onClose: onClose,
          title: state.isNew
              ? 'questions.newTitle'.tr(namedArgs: {'qid': state.nextQid})
              : 'questions.editTitle'.tr(namedArgs: {'qid': original!.qid}),
          subtitle: isTrial
              ? StatusPill(
                  label: 'questions.trial'.tr(),
                  color: AdminTokens.trial,
                  icon: Icons.card_giftcard_rounded,
                  dense: true,
                )
              : null,
          isDirty: state.isDirty,
          isSaving: state.submitStatus.isLoading,
          // Saving mid-upload would drop the new image; wait for it.
          onSave: state.isDirty && !state.isUploading ? cubit.save : null,
          menu: state.isNew
              ? null
              : PopupMenuButton<void>(
                  tooltip: 'common.more'.tr(),
                  itemBuilder: (context) => [
                    PopupMenuItem<void>(
                      onTap: () => _confirmDelete(context, cubit, isTrial),
                      child: ListTile(
                        leading: const Icon(
                          Icons.delete_outline_rounded,
                          color: AppTheme.dangerColor,
                        ),
                        title: Text('questions.delete'.tr()),
                      ),
                    ),
                  ],
                ),
          aside: BlocSelector<QuestionEditorCubit, QuestionEditorState, QuestionModel>(
            selector: (state) => state.draft,
            builder: (context, draft) => QuizPreview(question: draft),
          ),
          children: [
            if (isTrial)
              _Banner(icon: Icons.card_giftcard_rounded, message: 'questions.trialBanner'.tr()),
            if (state.isNew && state.qidBreaksOrder)
              _Banner(
                icon: Icons.sort_rounded,
                message: 'questions.qidOrderBanner'.tr(namedArgs: {'qid': state.nextQid}),
              ),
            const _BasicsSection(),
            const QuestionImageField(),
            const AnswersEditor(),
          ],
        );
      },
    );
  }

  static Future<void> _confirmDelete(
    BuildContext context,
    QuestionEditorCubit cubit,
    bool isTrial,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'questions.deleteTitle'.tr(),
      message: isTrial ? 'questions.deleteTrialMessage'.tr() : 'questions.deleteMessage'.tr(),
      confirmLabel: 'questions.delete'.tr(),
      destructive: true,
    );
    if (confirmed) await cubit.delete();
  }
}

class _Banner extends StatelessWidget {
  const _Banner({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      color: AppTheme.warningBackgroundColor,
      borderColor: AppTheme.signalYellow,
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.turboOrange),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(child: Text(message, style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _BasicsSection extends StatefulWidget {
  const _BasicsSection();

  @override
  State<_BasicsSection> createState() => _BasicsSectionState();
}

class _BasicsSectionState extends State<_BasicsSection> {
  late final QuestionModel _initial = context.read<QuestionEditorCubit>().state.draft;
  late final _title = TextEditingController(text: _initial.title);
  late final _hint = TextEditingController(text: _initial.hint ?? '');

  @override
  void dispose() {
    _title.dispose();
    _hint.dispose();
    super.dispose();
  }

  Future<void> _changeType(QuestionEditorCubit cubit, QuestionType type) async {
    if (cubit.typeChangeLosesAnswers(type)) {
      final confirmed = await showConfirmDialog(
        context,
        title: 'questions.typeChangeTitle'.tr(),
        message: 'questions.typeChangeMessage'.tr(),
        confirmLabel: 'questions.typeChangeConfirm'.tr(),
        icon: Icons.swap_horiz_rounded,
      );
      if (!confirmed) return;
    }
    cubit.setType(type);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuestionEditorCubit>();
    return SectionCard(
      title: 'questions.basicsSection'.tr(),
      icon: Icons.edit_note_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _CategoryField(),
          const SizedBox(height: AppTheme.spacingM),
          BlocSelector<QuestionEditorCubit, QuestionEditorState, QuestionType>(
            selector: (state) => state.draft.type,
            builder: (context, type) => SegmentedButton<QuestionType>(
              showSelectedIcon: false,
              segments: [
                for (final t in QuestionType.values)
                  ButtonSegment(value: t, label: Text('questions.types.${t.name}'.tr())),
              ],
              selected: {type},
              onSelectionChanged: (selection) => _changeType(cubit, selection.first),
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          BlocSelector<QuestionEditorCubit, QuestionEditorState, String?>(
            selector: (state) => state.errorOf('title'),
            builder: (context, error) => TextField(
              controller: _title,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'questions.questionTitle'.tr(),
                alignLabelWithHint: true,
                errorText: error?.tr(),
              ),
              onChanged: cubit.setTitle,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          TextField(
            controller: _hint,
            decoration: InputDecoration(
              labelText: 'questions.hint'.tr(),
              prefixIcon: const Icon(Icons.lightbulb_outline_rounded),
            ),
            onChanged: cubit.setHint,
          ),
        ],
      ),
    );
  }
}

class _CategoryField extends StatelessWidget {
  const _CategoryField();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuestionEditorCubit>();
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      buildWhen: (previous, current) => previous.categories != current.categories,
      builder: (context, categories) =>
          BlocSelector<QuestionEditorCubit, QuestionEditorState, (String, String?)>(
            selector: (state) => (state.draft.categorySlug, state.errorOf('category')),
            builder: (context, values) {
              final (slug, error) = values;
              final known = categories.bySlug(slug) != null;
              return DropdownButtonFormField<String>(
                // Rebuild when the options change so the initial value stays valid.
                key: ValueKey('${categories.categories.length}-$known'),
                initialValue: known ? slug : null,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'questions.category'.tr(),
                  errorText: error?.tr(),
                ),
                items: [
                  for (final category in categories.categories)
                    DropdownMenuItem(value: category.slug, child: Text(category.name)),
                ],
                onChanged: cubit.setCategory,
              );
            },
          ),
    );
  }
}
