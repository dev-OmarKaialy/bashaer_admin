import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/admin/status_pill.dart';
import '../../data/models/license_status.dart';

/// One look per status, everywhere (list, editor, sheet).
class LicenseStatusStyle {
  const LicenseStatusStyle(this.labelKey, this.color, this.background, this.icon);

  final String labelKey;
  final Color color;
  final Color background;
  final IconData icon;

  static LicenseStatusStyle of(LicenseStatus status) => switch (status) {
    LicenseStatus.pending => const LicenseStatusStyle(
      'licenses.status.pending',
      AppTheme.turboOrange,
      AppTheme.warningBackgroundColor,
      Icons.hourglass_top_rounded,
    ),
    LicenseStatus.active => const LicenseStatusStyle(
      'licenses.status.active',
      AppTheme.successColor,
      AppTheme.successBackgroundColor,
      Icons.verified_rounded,
    ),
    LicenseStatus.expiring => const LicenseStatusStyle(
      'licenses.status.expiring',
      AppTheme.turboOrange,
      AppTheme.warningBackgroundColor,
      Icons.schedule_rounded,
    ),
    LicenseStatus.expired => const LicenseStatusStyle(
      'licenses.status.expired',
      AppTheme.dangerColor,
      AppTheme.dangerBackgroundColor,
      Icons.event_busy_rounded,
    ),
    LicenseStatus.revoked => const LicenseStatusStyle(
      'licenses.status.revoked',
      AppTheme.inkSoft,
      AppTheme.mutedSurface,
      Icons.block_rounded,
    ),
  };
}

class LicenseStatusPill extends StatelessWidget {
  const LicenseStatusPill({super.key, required this.status, this.dense = false});

  final LicenseStatus status;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final style = LicenseStatusStyle.of(status);
    return AnimatedSwitcher(
      duration: AdminTokens.fast,
      child: StatusPill(
        key: ValueKey(status),
        label: style.labelKey.tr(),
        color: style.color,
        background: style.background,
        icon: style.icon,
        dense: dense,
      ),
    );
  }
}
