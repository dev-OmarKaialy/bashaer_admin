import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/utils/license_dates.dart';
import '../../../../core/widgets/localized_date_picker.dart';

/// Preset chips (1 / 3 / 6 / 12 months) plus a free date picker, and a line
/// saying exactly what will happen ("نشط حتى ... (98 يومًا)").
class LicensePeriodPicker extends StatelessWidget {
  const LicensePeriodPicker({
    super.key,
    required this.selectedPreset,
    required this.until,
    required this.onPreset,
    required this.onDate,
    this.enabled = true,
  });

  final int? selectedPreset;
  final DateTime? until;
  final ValueChanged<int> onPreset;
  final ValueChanged<DateTime> onDate;
  final bool enabled;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final initial = until != null && until!.isAfter(tomorrow) ? until!.toLocal() : tomorrow;
    final picked = await showLocalizedDatePicker(
      context: context,
      firstDate: tomorrow,
      lastDate: DateTime(now.year + 5, 12, 31),
      initialDate: initial,
    );
    if (picked != null) onDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final selectedUntil = until;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: AppTheme.spacingS,
          runSpacing: AppTheme.spacingS,
          children: [
            for (final months in LicenseDates.presets)
              ChoiceChip(
                label: Text(plural('licenses.months', months)),
                selected: selectedPreset == months,
                showCheckmark: false,
                onSelected: enabled ? (_) => onPreset(months) : null,
              ),
            ActionChip(
              avatar: const Icon(Icons.calendar_month_rounded, size: 18),
              label: Text('licenses.pickDate'.tr()),
              onPressed: enabled ? () => _pickDate(context) : null,
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingM),
        AnimatedSwitcher(
          duration: AdminTokens.fast,
          child: selectedUntil == null
              ? Text(
                  'licenses.choosePeriod'.tr(),
                  key: const ValueKey('none'),
                  style: textTheme.bodyMedium?.copyWith(color: AppTheme.inkFaint),
                )
              : _UntilSummary(key: ValueKey(selectedUntil), until: selectedUntil),
        ),
      ],
    );
  }
}

class _UntilSummary extends StatelessWidget {
  const _UntilSummary({super.key, required this.until});

  final DateTime until;

  @override
  Widget build(BuildContext context) {
    final days = AppFormatters.daysFromToday(until, DateTime.now());
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.successBackgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        child: Row(
          children: [
            const Icon(Icons.event_available_rounded, color: AppTheme.successColor, size: 20),
            const SizedBox(width: AppTheme.spacingS),
            Expanded(
              child: Text(
                'licenses.activeUntilSummary'.tr(
                  namedArgs: {
                    'date': AppFormatters.longDate(until),
                    'days': AppFormatters.days(days),
                  },
                ),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
