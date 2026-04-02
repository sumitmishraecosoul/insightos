import 'package:flutter/material.dart';
import 'package:insightos/core/theme/app_spacing.dart';
import 'package:insightos/core/theme/theme_extensions.dart';
import 'package:insightos/shared/models/legend_item.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend({super.key, required this.items});

  final List<LegendItem> items;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.lg,
      runSpacing: AppSpacing.sm,
      children: [
        for (final item in items)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                item.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: context.appColors.textSecondary,
                    ),
              ),
            ],
          ),
      ],
    );
  }
}
