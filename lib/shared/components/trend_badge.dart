import 'package:flutter/material.dart';
import 'package:insightos/core/theme/app_spacing.dart';
import 'package:insightos/core/theme/theme_extensions.dart';

class TrendBadge extends StatelessWidget {
  const TrendBadge({super.key, required this.trend});

  final String trend;

  @override
  Widget build(BuildContext context) {
    final (label, color, icon) = switch (trend) {
      'up' => ('Up', context.appColors.success, Icons.arrow_upward_rounded),
      'down' => (
        'Down',
        context.appColors.danger,
        Icons.arrow_downward_rounded,
      ),
      _ => ('Flat', context.appColors.textTertiary, Icons.remove_rounded),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha:0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
