import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/license_dates.dart';
import '../../../../core/widgets/admin/id_text.dart';
import '../../data/models/license_model.dart';
import '../../data/models/license_status.dart';
import 'license_period_picker.dart';
import 'license_status_pill.dart';

/// Label of the grant button for a row in [status].
String grantLabelKey(LicenseStatus status) => switch (status) {
  LicenseStatus.pending => 'licenses.actions.approve',
  LicenseStatus.active || LicenseStatus.expiring => 'licenses.actions.extend',
  LicenseStatus.expired => 'licenses.actions.renew',
  LicenseStatus.revoked => 'licenses.actions.restore',
};

/// Two-tap approve from the list: pick a period (3 months preselected),
/// confirm. Resolves to the chosen end date, or null when dismissed.
Future<DateTime?> showQuickGrantSheet(BuildContext context, LicenseModel license) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    constraints: const BoxConstraints(maxWidth: 520),
    builder: (context) => _QuickGrantSheet(license: license),
  );
}

class _QuickGrantSheet extends StatefulWidget {
  const _QuickGrantSheet({required this.license});

  final LicenseModel license;

  @override
  State<_QuickGrantSheet> createState() => _QuickGrantSheetState();
}

class _QuickGrantSheetState extends State<_QuickGrantSheet> {
  static const _defaultPreset = 3;

  late final LicenseStatus _status = statusOf(widget.license, DateTime.now());
  late final ValueNotifier<int?> _preset = ValueNotifier(_defaultPreset);
  late final ValueNotifier<DateTime?> _until = ValueNotifier(_presetUntil(_defaultPreset));

  @override
  void dispose() {
    _preset.dispose();
    _until.dispose();
    super.dispose();
  }

  DateTime _presetUntil(int months) {
    final current = _status == LicenseStatus.revoked ? null : widget.license.activeUntil;
    return LicenseDates.presetUntil(now: DateTime.now(), currentUntil: current, months: months);
  }

  @override
  Widget build(BuildContext context) {
    final license = widget.license;
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppTheme.spacingXL,
          0,
          AppTheme.spacingXL,
          AppTheme.spacingXL + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(grantLabelKey(_status).tr(), style: textTheme.headlineSmall),
            const SizedBox(height: AppTheme.spacingS),
            Row(
              children: [
                LicenseStatusPill(status: _status, dense: true),
                const SizedBox(width: AppTheme.spacingS),
                if (license.displayName != null)
                  Flexible(
                    child: Text(
                      license.displayName!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium,
                    ),
                  )
                else
                  Flexible(child: IdText(id: license.deviceId, copyable: false)),
              ],
            ),
            const SizedBox(height: AppTheme.spacingL),
            ListenableBuilder(
              listenable: Listenable.merge([_preset, _until]),
              builder: (context, _) => LicensePeriodPicker(
                selectedPreset: _preset.value,
                until: _until.value,
                onPreset: (months) {
                  _preset.value = months;
                  _until.value = _presetUntil(months);
                },
                onDate: (day) {
                  _preset.value = null;
                  _until.value = LicenseDates.endOfLocalDay(day);
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            ValueListenableBuilder<DateTime?>(
              valueListenable: _until,
              builder: (context, until, _) => FilledButton.icon(
                autofocus: true,
                onPressed: until == null ? null : () => Navigator.of(context).pop(until),
                icon: const Icon(Icons.check_rounded),
                label: Text(grantLabelKey(_status).tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
