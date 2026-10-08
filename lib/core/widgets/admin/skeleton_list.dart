import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../theme/app_theme.dart';

/// Placeholder rows with the same height as real rows, so nothing jumps when
/// data arrives. Shimmers unless the platform asks for reduced motion.
class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, required this.itemExtent, this.count = 8});

  final double itemExtent;
  final int count;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final list = ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemExtent: itemExtent,
      itemCount: count,
      itemBuilder: (context, index) => const _SkeletonRow(),
    );
    if (reduceMotion) return list;
    return list
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1200.ms, color: AppTheme.cardSurface.withValues(alpha: 0.7));
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingL, vertical: AppTheme.spacingS),
      child: Row(
        children: [
          _Bone(width: 44, height: 44, radius: AppTheme.radiusS),
          SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FractionallySizedBox(widthFactor: 0.7, child: _Bone(height: 14)),
                SizedBox(height: AppTheme.spacingS),
                FractionallySizedBox(widthFactor: 0.4, child: _Bone(height: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({this.width, required this.height, this.radius = 6});

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppTheme.mutedSurface,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: SizedBox(width: width, height: height),
    );
  }
}
