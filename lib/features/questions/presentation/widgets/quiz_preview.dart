import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/admin/admin_network_image.dart';
import '../../../../core/widgets/race_card.dart';
import '../../data/models/question_model.dart';

/// The question as students see it in practice mode after answering
/// correctly: same card, tags, image, answer cards (correct ones in green) and
/// explanation. Mirrors the students' `_QuestionCard` / `AnswerOptionCard`,
/// without animations and with network-only images (their image widget reads
/// files through `dart:io`, which web can't use).
class QuizPreview extends StatelessWidget {
  const QuizPreview({super.key, required this.question});

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final image = question.image;
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('common.preview'.tr(), style: textTheme.labelMedium),
          const SizedBox(height: AppTheme.spacingS),
          RaceCard(
            radius: AppTheme.radiusXL,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    RaceTag(
                      label: 'questions.types.${question.type.name}'.tr(),
                      color: AppTheme.electricViolet,
                      icon: Icons.radio_button_checked_rounded,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                if (image != null) ...[
                  AdminNetworkImage(
                    url: image,
                    height: 200,
                    radius: AppTheme.radiusM,
                    semanticLabel: question.title,
                  ),
                  const SizedBox(height: 14),
                ],
                Text(
                  question.title.trim().isEmpty
                      ? 'questions.titlePlaceholder'.tr()
                      : question.title,
                  style: textTheme.headlineSmall?.copyWith(
                    color: question.title.trim().isEmpty ? AppTheme.inkFaint : null,
                  ),
                ),
                const SizedBox(height: 18),
                for (var i = 0; i < question.answers.length; i++) ...[
                  if (i > 0) const SizedBox(height: 10),
                  _PreviewAnswer(
                    answer: question.answers[i],
                    index: i,
                    correct: question.correctAnswerIds.contains(question.answers[i].id),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewAnswer extends StatelessWidget {
  const _PreviewAnswer({required this.answer, required this.index, required this.correct});

  final AnswerModel answer;
  final int index;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    final accent = AppTheme.accentGradientAt(index);
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: correct ? AppTheme.successBackgroundColor : AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(AppTheme.radiusM),
        border: Border.all(
          color: correct ? AppTheme.successColor : AppTheme.divider,
          width: correct ? 2 : 1.4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: correct ? AppTheme.limeGradient : null,
                color: correct ? null : accent.colors.first.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppTheme.radiusS),
              ),
              child: SizedBox.square(
                dimension: 38,
                child: Center(
                  child: Text(
                    // Same letters as the students' app.
                    String.fromCharCode(0x0627 + index),
                    style: textTheme.titleLarge?.copyWith(
                      color: correct ? AppTheme.onPrimaryColor : accent.colors.first,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (answer.image != null) ...[
                    AdminNetworkImage(url: answer.image!, height: 72),
                    const SizedBox(height: 8),
                  ],
                  Text(answer.text.trim().isEmpty ? '—' : answer.text, style: textTheme.bodyLarge),
                ],
              ),
            ),
            if (correct)
              const Icon(Icons.check_circle_rounded, color: AppTheme.successColor, size: 26),
          ],
        ),
      ),
    );
  }
}
