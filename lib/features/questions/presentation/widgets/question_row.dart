import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/admin/admin_network_image.dart';
import '../../../../core/widgets/admin/id_text.dart';
import '../../../../core/widgets/admin/status_pill.dart';
import '../../data/models/question_model.dart';

/// One fixed-height question row: qid, trial mark, thumbnail, title, type and
/// category.
class QuestionRow extends StatelessWidget {
  const QuestionRow({
    super.key,
    required this.question,
    required this.categoryName,
    required this.selected,
    required this.onOpen,
  });

  final QuestionModel question;
  final String? categoryName;
  final bool selected;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final image = question.image;
    return Material(
      color: selected ? AdminTokens.selectedRow : AppTheme.cardSurface,
      child: InkWell(
        onTap: onOpen,
        hoverColor: AdminTokens.hoverRow,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(color: selected ? AppTheme.nitroBlue : AdminTokens.clear, width: 3),
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppTheme.spacingM,
              AppTheme.spacingS,
              AppTheme.spacingL,
              AppTheme.spacingS,
            ),
            child: Row(
              children: [
                SizedBox.square(
                  dimension: 48,
                  child: image != null
                      ? RepaintBoundary(child: AdminNetworkImage(url: image, width: 48, height: 48))
                      : DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppTheme.mutedSurface,
                            borderRadius: BorderRadius.circular(AppTheme.radiusS),
                          ),
                          child: Icon(
                            question.type == QuestionType.trueFalse
                                ? Icons.rule_rounded
                                : Icons.radio_button_checked_rounded,
                            color: AppTheme.inkSoft,
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
                        question.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          IdText(id: question.qid, copyable: false, size: 12),
                          if (question.isTrial) ...[
                            const SizedBox(width: AppTheme.spacingXS),
                            StatusPill(
                              label: 'questions.trial'.tr(),
                              color: AdminTokens.trial,
                              dense: true,
                            ),
                          ],
                          const SizedBox(width: AppTheme.spacingS),
                          Flexible(
                            child: Text(
                              [
                                'questions.types.${question.type.name}'.tr(),
                                ?categoryName,
                              ].join(' · '),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
