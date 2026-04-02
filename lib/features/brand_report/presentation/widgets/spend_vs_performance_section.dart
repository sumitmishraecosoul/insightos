import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:insightos/features/brand_report/utils/chart_utils.dart';
import 'package:insightos/shared/components/chart_legend.dart';
import 'package:insightos/shared/models/legend_item.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/utils/number_formatters.dart';
// import 'section_header.dart';

/// Weekly spend vs ROAS line chart section (last 8 weeks).
class SpendVsPerformanceSection extends StatelessWidget {
  const SpendVsPerformanceSection({
    super.key,
    required this.weeklySpend,
    required this.weeklyRoas,
  });

  final List<num> weeklySpend;
  final List<num> weeklyRoas;

  static const Duration _animDuration = Duration(milliseconds: 900);
  static const double _chartHeight = 140;
  static const int _weeks = 8;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spend vs ROAS · 8 Weeks',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: context.appColors.textTertiary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: _animDuration,
              curve: Curves.easeOutCubic,
              builder: (context, animValue, child) {
                return SizedBox(
                  height: _chartHeight,
                  child: _buildChart(context, animValue),
                );
              },
            ),
            const SizedBox(height: 6),
            ChartLegend(
              items: [
                LegendItem(
                  label: 'Weekly Spend (₹)',
                  color: context.appColors.brand,
                ),
                LegendItem(label: 'ROAS', color: context.appColors.success),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(BuildContext context, double animValue) {
    final spend = weeklySpend.take(_weeks).toList(growable: false);
    final roas = weeklyRoas.take(_weeks).toList(growable: false);
    final n = spend.length < roas.length ? spend.length : roas.length;

    if (n == 0) {
      return Center(
        child: Text(
          'No data',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: context.appColors.textTertiary,
          ),
        ),
      );
    }

    final spendMin = ChartUtils.min(spend);
    final spendMax = ChartUtils.max(spend);
    final roasMin = ChartUtils.min(roas);
    final roasMax = ChartUtils.max(roas);

    final spendSpots = <FlSpot>[
      for (var i = 0; i < n; i++)
        FlSpot(
          i.toDouble(),
          ChartUtils.normalize(spend[i].toDouble(), spendMin, spendMax) *
              animValue,
        ),
    ];
    final roasSpots = <FlSpot>[
      for (var i = 0; i < n; i++)
        FlSpot(
          i.toDouble(),
          ChartUtils.normalize(roas[i].toDouble(), roasMin, roasMax) *
              animValue,
        ),
    ];

    final gridColor = context.appColors.border.withValues(alpha: 0.6);

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 12,
            tooltipPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            tooltipMargin: 10,
            getTooltipColor: (touchedSpot) => context.appColors.cardAlt,
            getTooltipItems: (touchedSpots) {
              return touchedSpots
                  .map((spot) {
                    final i = spot.x.toInt().clamp(0, n - 1);
                    final isSpend = spot.barIndex == 0;
                    final raw = isSpend ? spend[i] : roas[i];
                    final label = isSpend
                        ? 'Spend: ${NumberFormatters.compactRs(raw)}'
                        : 'ROAS: ${NumberFormatters.fixed(raw, decimals: 2)}';
                    final color = isSpend
                        ? context.appColors.brand
                        : context.appColors.success;
                    return LineTooltipItem(
                      label,
                      Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: context.appColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: '\nW${i + 1}',
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                color: context.appColors.textTertiary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    );
                  })
                  .toList(growable: false);
            },
          ),
        ),
        minX: 0,
        maxX: (n - 1).toDouble(),
        minY: 0,
        maxY: 1,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 0.25,
          getDrawingHorizontalLine: (value) =>
              FlLine(color: gridColor, strokeWidth: 0.7),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: context.appColors.border),
            left: BorderSide(color: context.appColors.border),
            right: BorderSide(color: context.appColors.border),
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                final i = value.toInt();
                return Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Text(
                    'W${i + 1}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: context.appColors.textTertiary,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 44,
              interval: 0.25,
              getTitlesWidget: (value, meta) {
                final denorm =
                    spendMin + value.clamp(0, 1) * (spendMax - spendMin);
                return Text(
                  NumberFormatters.compactInr(denorm, decimals: 1),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.appColors.textTertiary,
                  ),
                );
              },
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              interval: 0.25,
              getTitlesWidget: (value, meta) {
                final denorm =
                    roasMin + value.clamp(0, 1) * (roasMax - roasMin);
                return Text(
                  NumberFormatters.fixed(denorm, decimals: 2),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.appColors.textTertiary,
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spendSpots,
            isCurved: true,
            color: context.appColors.brand,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.appColors.brand.withValues(alpha: 0.25),
                  context.appColors.brand.withValues(alpha: 0),
                ],
              ),
            ),
          ),
          LineChartBarData(
            spots: roasSpots,
            isCurved: true,
            color: context.appColors.success,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  context.appColors.success.withValues(alpha: 0.20),
                  context.appColors.success.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ],
      ),
      duration: Duration.zero,
    );
  }
}
