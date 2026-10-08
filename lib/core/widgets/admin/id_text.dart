import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_theme.dart';
import '../../utils/toaster.dart';

/// An identifier (device id, qid, slug) in the monospace number font, with a
/// copy button. Long ids are shortened unless [full] is true.
class IdText extends StatelessWidget {
  const IdText({
    super.key,
    required this.id,
    this.full = false,
    this.copyable = true,
    this.size = 13,
    this.color = AppTheme.inkSoft,
  });

  final String id;
  final bool full;
  final bool copyable;
  final double size;
  final Color color;

  static String shorten(String id) {
    if (id.length <= 14) return id;
    return '${id.substring(0, 6)}…${id.substring(id.length - 4)}';
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.numberStyle(size, color: color).copyWith(fontWeight: FontWeight.w600);
    final text = full ? SelectableText(id, style: style) : Text(shorten(id), style: style);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Directionality(textDirection: TextDirection.ltr, child: text),
        ),
        if (copyable)
          IconButton(
            tooltip: 'common.copy'.tr(),
            visualDensity: VisualDensity.compact,
            iconSize: 16,
            color: AppTheme.inkFaint,
            icon: const Icon(Icons.copy_rounded),
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: id));
              Toaster.showSuccess('common.copied'.tr());
            },
          ),
      ],
    );
  }
}
