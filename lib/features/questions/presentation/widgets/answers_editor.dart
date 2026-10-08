import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/admin/motion.dart';
import '../../../../core/widgets/admin/panel_card.dart';
import '../../data/models/question_model.dart';
import '../cubit/question_editor_cubit.dart';

/// Answers with their correct marks. The list only rebuilds when answers are
/// added, removed or the type changes; typing in one answer rebuilds only
/// that answer's row.
class AnswersEditor extends StatelessWidget {
  const AnswersEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionEditorCubit, QuestionEditorState>(
      buildWhen: (previous, current) =>
          previous.draft.type != current.draft.type ||
          !_sameIds(previous.draft.answers, current.draft.answers) ||
          previous.errorOf('answers') != current.errorOf('answers') ||
          previous.errorOf('correct') != current.errorOf('correct'),
      builder: (context, state) {
        final cubit = context.read<QuestionEditorCubit>();
        final type = state.draft.type;
        final answerError = state.errorOf('answers') ?? state.errorOf('correct');
        final textTheme = Theme.of(context).textTheme;
        return SectionCard(
          title: 'questions.answersSection'.tr(),
          icon: Icons.format_list_bulleted_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('questions.correctHintSingle'.tr(), style: textTheme.bodySmall),
              const SizedBox(height: AppTheme.spacingM),
              for (var i = 0; i < state.draft.answers.length; i++)
                // New answers slide in; existing ones stagger in on open.
                Entrance(
                  key: ValueKey('${type.name}-${state.draft.answers[i].id}'),
                  index: i,
                  offsetY: 0.2,
                  child: _AnswerRow(answerId: state.draft.answers[i].id, index: i),
                ),
              if (answerError != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                  child: Text(
                    answerError.tr(),
                    style: textTheme.bodySmall?.copyWith(color: AppTheme.dangerColor),
                  ),
                ),
              if (type != QuestionType.trueFalse)
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: cubit.canAddAnswer ? cubit.addAnswer : null,
                    icon: const Icon(Icons.add_rounded),
                    label: Text('questions.addAnswer'.tr()),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  static bool _sameIds(List<AnswerModel> a, List<AnswerModel> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i].id != b[i].id) return false;
    }
    return true;
  }
}

class _AnswerRow extends StatefulWidget {
  const _AnswerRow({required this.answerId, required this.index});

  final String answerId;
  final int index;

  @override
  State<_AnswerRow> createState() => _AnswerRowState();
}

class _AnswerRowState extends State<_AnswerRow> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final answers = context.read<QuestionEditorCubit>().state.draft.answers;
    final answer = answers.where((a) => a.id == widget.answerId).firstOrNull;
    _controller = TextEditingController(text: answer?.text ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<QuestionEditorCubit>();
    return BlocSelector<QuestionEditorCubit, QuestionEditorState, (bool, QuestionType, String?)>(
      selector: (state) => (
        state.draft.correctAnswerIds.contains(widget.answerId),
        state.draft.type,
        state.errorOf('answer:${widget.answerId}'),
      ),
      builder: (context, values) {
        final (isCorrect, type, error) = values;
        final isTrueFalse = type == QuestionType.trueFalse;
        final icon = (isCorrect
            ? Icons.radio_button_checked_rounded
            : Icons.radio_button_off_rounded);
        return Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
          child: AnimatedContainer(
            duration: AdminTokens.fast,
            decoration: BoxDecoration(
              color: isCorrect ? AppTheme.successBackgroundColor : AppTheme.cardSurface,
              borderRadius: BorderRadius.circular(AppTheme.radiusM),
              border: Border.all(color: isCorrect ? AppTheme.successColor : AppTheme.divider),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  tooltip: isCorrect
                      ? 'questions.markedCorrect'.tr()
                      : 'questions.markCorrect'.tr(),
                  icon: Icon(icon),
                  color: isCorrect ? AppTheme.successColor : AppTheme.inkFaint,
                  onPressed: () => cubit.toggleCorrect(widget.answerId),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingXS),
                    child: TextField(
                      controller: _controller,
                      readOnly: isTrueFalse,
                      autofocus: !isTrueFalse && _controller.text.isEmpty && widget.index > 1,
                      minLines: 1,
                      maxLines: 3,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: false,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'questions.answerHint'.tr(
                          namedArgs: {'n': '${widget.index + 1}'},
                        ),
                        errorText: error?.tr(),
                      ),
                      onChanged: (text) => cubit.setAnswerText(widget.answerId, text),
                    ),
                  ),
                ),
                if (!isTrueFalse)
                  IconButton(
                    tooltip: 'questions.removeAnswer'.tr(),
                    icon: const Icon(Icons.close_rounded),
                    color: AppTheme.inkFaint,
                    onPressed: cubit.canRemoveAnswer
                        ? () {
                            final removed = cubit.removeAnswer(widget.answerId);
                            if (removed == null) return;
                            Toaster.showSuccess(
                              'questions.toast.answerRemoved'.tr(),
                              actionLabel: 'common.undo'.tr(),
                              onAction: () => cubit.restoreAnswer(removed),
                            );
                          }
                        : null,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
