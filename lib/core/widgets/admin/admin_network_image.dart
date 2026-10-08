import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

/// The only network image widget in the admin app.
///
/// - Decodes at the rendered size (`cacheWidth`), so a 48 px thumbnail never
///   decodes a 1600 px upload.
/// - On web, falls back to an HTML `<img>` when the host sends no CORS headers.
/// - Fixed box with placeholder and error states, so layout never jumps.
class AdminNetworkImage extends StatelessWidget {
  const AdminNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.radius = AppTheme.radiusS,
    this.semanticLabel,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double radius;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppTheme.mutedSurface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: AppTheme.divider),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final logicalWidth = width ?? constraints.maxWidth;
              final dpr = MediaQuery.devicePixelRatioOf(context);
              final cacheWidth = logicalWidth.isFinite ? (logicalWidth * dpr).round() : null;
              return Image.network(
                url,
                fit: fit,
                width: width,
                height: height,
                cacheWidth: cacheWidth,
                gaplessPlayback: true,
                semanticLabel: semanticLabel,
                webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                    child: SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.broken_image_outlined, color: AppTheme.inkFaint),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
