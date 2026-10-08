import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/env.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/widgets/admin/admin_network_image.dart';
import '../../../../core/widgets/admin/panel_card.dart';
import '../cubit/question_editor_cubit.dart';

/// Optional question image: upload (when an ImgBB key is configured), paste
/// a link, replace or remove. The rest of the form stays usable while an
/// upload runs.
class QuestionImageField extends StatelessWidget {
  const QuestionImageField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<QuestionEditorCubit, QuestionEditorState, (String?, RequestStatus)>(
      selector: (state) => (state.draft.image, state.imageStatus),
      builder: (context, values) {
        final (url, status) = values;
        final cubit = context.read<QuestionEditorCubit>();
        final uploading = status.isLoading;
        final actions = Wrap(
          spacing: AppTheme.spacingS,
          runSpacing: AppTheme.spacingS,
          children: [
            if (Env.hasImgbb)
              OutlinedButton.icon(
                onPressed: uploading ? null : cubit.pickAndUploadImage,
                icon: const Icon(Icons.upload_rounded),
                label: Text(
                  url == null ? 'questions.uploadImage'.tr() : 'questions.replaceImage'.tr(),
                ),
              ),
            TextButton.icon(
              onPressed: uploading ? null : () => _pasteUrl(context, cubit),
              icon: const Icon(Icons.link_rounded),
              label: Text('questions.pasteImageUrl'.tr()),
            ),
            if (url != null)
              TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: AppTheme.dangerColor),
                onPressed: uploading ? null : cubit.removeImage,
                icon: const Icon(Icons.delete_outline_rounded),
                label: Text('questions.removeImage'.tr()),
              ),
          ],
        );
        return SectionCard(
          title: 'questions.imageSection'.tr(),
          icon: Icons.image_outlined,
          trailing: Text('common.optional'.tr(), style: Theme.of(context).textTheme.labelSmall),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.square(
                dimension: 112,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (url != null)
                      AdminNetworkImage(url: url, width: 112, height: 112, fit: BoxFit.cover)
                    else
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppTheme.skyBackground,
                          borderRadius: BorderRadius.circular(AppTheme.radiusS),
                          border: Border.all(color: AppTheme.divider, width: 1.5),
                        ),
                        child: const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 36,
                          color: AppTheme.inkFaint,
                        ),
                      ),
                    if (uploading)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppTheme.cardSurface.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(AppTheme.radiusS),
                        ),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacingL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uploading
                          ? 'questions.uploading'.tr()
                          : Env.hasImgbb
                          ? 'questions.imageHelp'.tr()
                          : 'questions.imageHelpNoUpload'.tr(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppTheme.spacingS),
                    actions,
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> _pasteUrl(BuildContext context, QuestionEditorCubit cubit) async {
    final url = await showDialog<String>(context: context, builder: (_) => const _UrlDialog());
    if (url == null) return;
    cubit.setImageUrl(url);
  }
}

class _UrlDialog extends StatefulWidget {
  const _UrlDialog();

  @override
  State<_UrlDialog> createState() => _UrlDialogState();
}

class _UrlDialogState extends State<_UrlDialog> {
  final _controller = TextEditingController();
  final _error = ValueNotifier<String?>(null);

  @override
  void dispose() {
    _controller.dispose();
    _error.dispose();
    super.dispose();
  }

  void _submit() {
    final value = _controller.text.trim();
    final uri = Uri.tryParse(value);
    if (uri == null || !(uri.isScheme('http') || uri.isScheme('https')) || uri.host.isEmpty) {
      _error.value = 'questions.errors.badUrl'.tr();
      return;
    }
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('questions.pasteImageUrl'.tr()),
      content: SizedBox(
        width: 420,
        child: ValueListenableBuilder<String?>(
          valueListenable: _error,
          builder: (context, error, _) => TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: TextInputType.url,
            textDirection: TextDirection.ltr,
            decoration: InputDecoration(hintText: 'https://i.ibb.co/…', errorText: error),
            onSubmitted: (_) => _submit(),
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('common.cancel'.tr())),
        FilledButton(onPressed: _submit, child: Text('common.confirm'.tr())),
      ],
    );
  }
}
