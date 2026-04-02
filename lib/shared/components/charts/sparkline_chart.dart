import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:insightos/core/theme/theme_extensions.dart';

class Sparkline extends StatelessWidget {
  const Sparkline({super.key, required this.values});

  final List<num> values;

  static const double _lineWidth = 3;
  static const Duration _animDuration = Duration(milliseconds: 700);

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) {
      return Center(
        child: Text(
          'No trend data',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: context.appColors.textTertiary,
          ),
        ),
      );
    }

    final minV = values.reduce((a, b) => a < b ? a : b).toDouble();
    final maxV = values.reduce((a, b) => a > b ? a : b).toDouble();

    return LineChart(
      LineChartData(
        lineTouchData: const LineTouchData(enabled: false),
        minX: 0,
        maxX: (values.length - 1).toDouble(),
        minY: minV,
        maxY: maxV,
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              for (var i = 0; i < values.length; i++)
                FlSpot(i.toDouble(), values[i].toDouble()),
            ],
            isCurved: true,
            color: context.appColors.brand,
            barWidth: _lineWidth,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: context.appColors.brand.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
      duration: _animDuration,
      curve: Curves.easeOutCubic,
    );
  }
}
