import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/dependencies.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/utils/request_status.dart';
import '../../../../core/utils/toaster.dart';
import '../../../../core/widgets/admin/confirm_dialog.dart';
import '../../../../core/widgets/admin/editor_scaffold.dart';
import '../../../../core/widgets/admin/id_text.dart';
import '../../../../core/widgets/admin/panel_card.dart';
import '../../../../core/widgets/admin/state_views.dart';
import '../../data/models/license_status.dart';
import '../cubit/license_editor_cubit.dart';
import '../cubit/licenses_cubit.dart';
import '../widgets/license_period_picker.dart';
import '../widgets/license_status_pill.dart';
import '../widgets/quick_grant_sheet.dart';

/// Phone route around [LicenseEditorView].
class LicenseEditorScreen extends StatelessWidget {
  const LicenseEditorScreen({super.key, required this.deviceId});

  final String deviceId;

  @override
  Widget build(BuildContext context) => LicenseEditorView(deviceId: deviceId, isPane: false);
}

/// Access period (approve / extend / revoke) and the student's name, phone
/// and note for one license.
class LicenseEditorView extends StatelessWidget {
  const LicenseEditorView({
    super.key,
    required this.deviceId,
    required this.isPane,
    this.onClose,
    this.onDirtyChanged,
  });

  final String deviceId;
  final bool isPane;
  final VoidCallback? onClose;
  final ValueChanged<bool>? onDirtyChanged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LicenseEditorCubit>()..open(deviceId),
      child: MultiBlocListener(
        listeners: [
          BlocListener<LicenseEditorCubit, LicenseEditorState>(
            listenWhen: (previous, current) =>
                current.lastOutcome != null && previous.lastOutcome != current.lastOutcome,
            listener: (context, state) => _onOutcome(context, state.lastOutcome!),
          ),
          BlocListener<LicenseEditorCubit, LicenseEditorState>(
            listenWhen: (previous, current) => previous.isProfileDirty != current.isProfileDirty,
            listener: (context, state) => onDirtyChanged?.call(state.isProfileDirty),
          ),
        ],
        child: _EditorFrame(isPane: isPane, onClose: onClose),
      ),
    );
  }

  void _onOutcome(BuildContext context, LicenseEditorOutcome outcome) {
    if (outcome.errorKey != null) {
      Toaster.showError(outcome.errorKey!.tr());
      return;
    }
    if (outcome.action != LicenseEditorAction.profile) {
      context.read<LicensesCubit>().licenseChanged(deviceId);
    }
    final cubit = context.read<LicenseEditorCubit>();
    switch (outcome.action) {
      case LicenseEditorAction.grant:
        Toaster.showSuccess('licenses.toast.granted'.tr());
      case LicenseEditorAction.restore:
        Toaster.showSuccess('licenses.toast.restored'.tr());
      case LicenseEditorAction.profile:
        Toaster.showSuccess('licenses.toast.profileSaved'.tr());
      case LicenseEditorAction.revoke:
        final undoUntil = outcome.undoUntil;
        Toaster.showSuccess(
          'licenses.toast.revoked'.tr(),
          actionLabel: undoUntil == null ? null : 'common.undo'.tr(),
          onAction: undoUntil == null ? null : () => cubit.undoRevoke(undoUntil),
        );
    }
  }
}

class _EditorFrame extends StatelessWidget {
  const _EditorFrame({required this.isPane, this.onClose});

  final bool isPane;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LicenseEditorCubit, LicenseEditorState>(
      buildWhen: (previous, current) =>
          previous.loadStatus != current.loadStatus ||
          previous.license != current.license ||
          previous.isProfileDirty != current.isProfileDirty ||
          previous.profileStatus != current.profileStatus ||
          previous.accessStatus != current.accessStatus,
      builder: (context, state) {
        final license = state.license;
        if (license == null) {
          final body = state.loadStatus.isFailed
              ? ErrorState(message: (state.loadErrorKey ?? 'errors.unknown').tr())
              : const Center(child: CircularProgressIndicator());
          return isPane
              ? body
              : Scaffold(
                  appBar: AppBar(title: Text('licenses.editorTitle'.tr())),
                  body: body,
                );
        }
        final cubit = context.read<LicenseEditorCubit>();
        final status = statusOf(license, DateTime.now());
        final canRevoke = status == LicenseStatus.active || status == LicenseStatus.expiring;
        return EditorScaffold(
          isPane: isPane,
          onClose: onClose,
          title: license.displayName ?? 'licenses.editorTitle'.tr(),
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LicenseStatusPill(status: status, dense: true),
              const SizedBox(width: AppTheme.spacingS),
              Flexible(child: IdText(id: license.deviceId)),
            ],
          ),
          saveLabel: 'licenses.saveProfile'.tr(),
          isDirty: state.isProfileDirty,
          isSaving: state.profileStatus.isLoading,
          onSave: state.isProfileDirty ? cubit.saveProfile : null,
          menu: canRevoke
              ? PopupMenuButton<void>(
                  tooltip: 'common.more'.tr(),
                  itemBuilder: (context) => [
                    PopupMenuItem<void>(
                      onTap: () => _confirmRevoke(context, cubit),
                      child: ListTile(
                        leading: const Icon(Icons.block_rounded, color: AppTheme.dangerColor),
                        title: Text('licenses.actions.revoke'.tr()),
                      ),
                    ),
                  ],
                )
              : null,
          children: const [_AccessSection(), _ProfileSection(), _DetailsSection()],
        );
      },
    );
  }

  static Future<void> _confirmRevoke(BuildContext context, LicenseEditorCubit cubit) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'licenses.revokeTitle'.tr(),
      message: 'licenses.revokeMessage'.tr(),
      confirmLabel: 'licenses.actions.revoke'.tr(),
      destructive: true,
      icon: Icons.block_rounded,
    );
    if (confirmed) await cubit.revoke();
  }
}

class _AccessSection extends StatelessWidget {
  const _AccessSection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LicenseEditorCubit, LicenseEditorState>(
      buildWhen: (previous, current) =>
          previous.license != current.license ||
          previous.draftUntil != current.draftUntil ||
          previous.selectedPreset != current.selectedPreset ||
          previous.accessStatus != current.accessStatus,
      builder: (context, state) {
        final license = state.license!;
        final cubit = context.read<LicenseEditorCubit>();
        final now = DateTime.now();
        final status = statusOf(license, now);
        final until = license.activeUntil;
        final busy = state.accessStatus.isLoading;
        final textTheme = Theme.of(context).textTheme;
        return SectionCard(
          title: 'licenses.accessSection'.tr(),
          icon: Icons.key_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (until != null && status != LicenseStatus.pending) ...[
                Text(
                  status == LicenseStatus.revoked
                      ? 'licenses.revokedWasUntil'.tr(
                          namedArgs: {'date': AppFormatters.date(until)},
                        )
                      : '${AppFormatters.untilLabel(until, now)} · ${AppFormatters.longDate(until)}',
                  style: textTheme.bodyMedium?.copyWith(color: AppTheme.inkSoft),
                ),
                const SizedBox(height: AppTheme.spacingM),
              ],
              LicensePeriodPicker(
                enabled: !busy,
                selectedPreset: state.selectedPreset,
                until: state.draftUntil,
                onPreset: cubit.selectPreset,
                onDate: cubit.pickDate,
              ),
              const SizedBox(height: AppTheme.spacingL),
              Wrap(
                spacing: AppTheme.spacingS,
                runSpacing: AppTheme.spacingS,
                children: [
                  FilledButton.icon(
                    onPressed: busy || state.draftUntil == null ? null : cubit.grant,
                    icon: busy
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.verified_rounded),
                    label: Text(grantLabelKey(status).tr()),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileSection extends StatefulWidget {
  const _ProfileSection();

  @override
  State<_ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<_ProfileSection> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _note = TextEditingController();

  @override
  void initState() {
    super.initState();
    _syncFrom(context.read<LicenseEditorCubit>().state);
  }

  void _syncFrom(LicenseEditorState state) {
    if (_name.text != state.fullName) _name.text = state.fullName;
    if (_phone.text != state.phoneNumber) _phone.text = state.phoneNumber;
    if (_note.text != state.note) _note.text = state.note;
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LicenseEditorCubit>();
    return BlocListener<LicenseEditorCubit, LicenseEditorState>(
      listenWhen: (previous, current) => previous.formVersion != current.formVersion,
      listener: (context, state) => _syncFrom(state),
      child: SectionCard(
        title: 'licenses.profileSection'.tr(),
        icon: Icons.person_outline_rounded,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _name,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'licenses.fullName'.tr(),
                prefixIcon: const Icon(Icons.badge_outlined),
              ),
              onChanged: cubit.setFullName,
            ),
            const SizedBox(height: AppTheme.spacingM),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                labelText: 'licenses.phone'.tr(),
                prefixIcon: const Icon(Icons.phone_outlined),
              ),
              onChanged: cubit.setPhoneNumber,
            ),
            const SizedBox(height: AppTheme.spacingM),
            TextField(
              controller: _note,
              minLines: 2,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'licenses.note'.tr(),
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.sticky_note_2_outlined),
              ),
              onChanged: cubit.setNote,
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<LicenseEditorCubit, LicenseEditorState, (String, DateTime?, DateTime?)>(
      selector: (state) =>
          (state.license!.deviceId, state.license!.createdAt, state.license!.updatedAt),
      builder: (context, values) {
        final (deviceId, createdAt, updatedAt) = values;
        final textTheme = Theme.of(context).textTheme;
        return SectionCard(
          title: 'licenses.detailsSection'.tr(),
          icon: Icons.info_outline_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('licenses.deviceId'.tr(), style: textTheme.labelMedium),
              IdText(id: deviceId, full: true),
              if (createdAt != null) ...[
                const SizedBox(height: AppTheme.spacingS),
                Text(
                  'licenses.requestedAt'.tr(namedArgs: {'date': AppFormatters.dateTime(createdAt)}),
                  style: textTheme.bodySmall,
                ),
              ],
              if (updatedAt != null)
                Text(
                  'licenses.updatedAt'.tr(namedArgs: {'date': AppFormatters.dateTime(updatedAt)}),
                  style: textTheme.bodySmall,
                ),
            ],
          ),
        );
      },
    );
  }
}
