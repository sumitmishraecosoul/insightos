import 'package:flutter/material.dart';
import 'package:insightos/core/theme/app_spacing.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).dividerColor.withOpacity(0.18),
            highlightColor: Theme.of(context).dividerColor.withOpacity(0.05),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).dividerColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
