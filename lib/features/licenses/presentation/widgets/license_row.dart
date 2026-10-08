import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_formatters.dart';
import '../../../../core/widgets/admin/id_text.dart';
import '../../data/models/license_model.dart';
import '../../data/models/license_status.dart';
import '../cubit/licenses_cubit.dart';
import 'license_status_pill.dart';
import 'quick_grant_sheet.dart';

/// One fixed-height license row: status, who, when, and the one action that
/// fits the status (approve / extend / renew / restore).
class LicenseRow extends StatelessWidget {
  const LicenseRow({
    super.key,
    required this.item,
    required this.selected,
    required this.busy,
    required this.onOpen,
    required this.onQuickGrant,
  });

  final LicenseListItem item;
  final bool selected;
  final bool busy;
  final VoidCallback onOpen;
  final VoidCallback onQuickGrant;

  @override
  Widget build(BuildContext context) {
    final license = item.license;
    final style = LicenseStatusStyle.of(item.status);
    final textTheme = Theme.of(context).textTheme;
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
              AppTheme.spacingS,
              AppTheme.spacingS,
            ),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: style.background,
                    borderRadius: BorderRadius.circular(AppTheme.radiusS),
                  ),
                  child: SizedBox.square(
                    dimension: 44,
                    child: Icon(style.icon, color: style.color, size: 22),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (license.displayName != null)
                        Text(
                          license.displayName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleMedium,
                        )
                      else
                        IdText(
                          id: license.deviceId,
                          copyable: false,
                          color: AppTheme.ink,
                          size: 14,
                        ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          LicenseStatusPill(status: item.status, dense: true),
                          const SizedBox(width: AppTheme.spacingS),
                          Flexible(
                            child: _WhenText(license: license, status: item.status),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppTheme.spacingS),
                _QuickAction(status: item.status, busy: busy, onPressed: onQuickGrant),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WhenText extends StatelessWidget {
  const _WhenText({required this.license, required this.status});

  final LicenseModel license;
  final LicenseStatus status;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final until = license.activeUntil;
    final created = license.createdAt;
    final String text;
    if (status == LicenseStatus.pending || until == null) {
      text = created == null ? '' : AppFormatters.ago(created, now);
    } else if (status == LicenseStatus.revoked) {
      final changed = license.updatedAt;
      text = changed == null ? '' : AppFormatters.ago(changed, now);
    } else {
      text = AppFormatters.untilLabel(until, now);
    }
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodySmall,
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.status, required this.busy, required this.onPressed});

  final LicenseStatus status;
  final bool busy;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return const SizedBox(
        width: 48,
        height: 48,
        child: Center(
          child: SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      );
    }
    final label = grantLabelKey(status).tr();
    final primary = status == LicenseStatus.pending;
    const style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(48, 40)),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: AppTheme.spacingM)),
      visualDensity: VisualDensity.compact,
    );
    return primary
        ? FilledButton(onPressed: onPressed, style: style, child: Text(label))
        : OutlinedButton(onPressed: onPressed, style: style, child: Text(label));
  }
}
