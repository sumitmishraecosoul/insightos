import 'package:flutter/material.dart';
import 'package:insightos/core/theme/app_spacing.dart';
import 'package:insightos/core/theme/theme_extensions.dart';

class MiniInsightCard extends StatelessWidget {
  const MiniInsightCard({super.key, required this.zoneName, required this.trend});

  final String zoneName;
  final String trend;

  @override
  Widget build(BuildContext context) {
    final (title, body, color, icon) = switch (trend) {
      'up' => (
        'Opportunity spotted',
        'Momentum in $zoneName is positive. Consider reallocating small budget to test scaling.',
        context.appColors.success,
        Icons.lightbulb_outline_rounded,
      ),
      'down' => (
        'Attention needed',
        '$zoneName is trending down. Review targeting/creative and check recent spend efficiency.',
        context.appColors.warning,
        Icons.warning_amber_rounded,
      ),
      _ => (
        'FYI',
        '$zoneName is stable. Monitor key metrics and look for small optimizations.',
        context.appColors.brand,
        Icons.info_outline_rounded,
      ),
    };

    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.22)),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: context.appColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
