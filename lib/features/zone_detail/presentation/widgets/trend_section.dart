import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/components/charts/sparkline_chart.dart';

class TrendSection extends StatelessWidget {
  const TrendSection({
    super.key,
    required this.values,
  });

  final List<num> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('4-Week Trend'),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 56,
            child: Sparkline(values: values),
          ),
        ],
      ),
    );
  }
}