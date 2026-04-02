import 'package:flutter/material.dart';
import 'package:insightos/features/zone_detail/presentation/widgets/metric_tile.dart';
import 'package:insightos/features/zone_detail/presentation/widgets/mini_insight_card.dart';
import 'package:insightos/features/zone_detail/presentation/widgets/trend_section.dart';
import 'package:insightos/features/zone_detail/presentation/widgets/zone_header.dart';
import 'package:insightos/features/zone_detail/utils/zone_ui_utils.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../data/models/zone.dart';

/// Zone detail draggable bottom sheet.
class ZoneDetailBottomSheet extends StatelessWidget {
  const ZoneDetailBottomSheet({super.key, required this.zone});

  final Zone zone;

  static const double _minChildSize = 0.4;
  static const double _maxChildSize = 0.85;
  static const double _initialChildSize = 0.55;

  @override
  Widget build(BuildContext context) {
    final pm = zone.primaryMetric;
    final trendText = ZoneUIUtils.trendLine(pm.trend, pm.changePct);

    return DraggableScrollableSheet(
      minChildSize: _minChildSize,
      maxChildSize: _maxChildSize,
      initialChildSize: _initialChildSize,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.xl + MediaQuery.of(context).padding.bottom + 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ZoneHeader(
                zoneName: zone.name,
                onClose: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                '${pm.value}×',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: context.appColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                pm.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.appColors.textTertiary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                trendText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ZoneUIUtils.trendColor(context, pm.trend),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              TrendSection(values: zone.trend4w),
              const SizedBox(height: AppSpacing.xl),
              Text(
                'Key metrics',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: context.appColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isNarrow = constraints.maxWidth < 360;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      // Give tiles more vertical room on small devices to avoid pixel overflows.
                      childAspectRatio: isNarrow ? 2.15 : 2.35,
                    ),
                    itemCount: zone.metrics.length,
                    itemBuilder: (context, index) {
                      final m = zone.metrics[index];
                      return MetricTile(
                        label: m.label,
                        value: m.value,
                        unit: m.unit,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              MiniInsightCard(zoneName: zone.name, trend: pm.trend),
              const SizedBox(height: AppSpacing.xl),
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'Viewing full zone report for: ${zone.name}',
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                },
                style: FilledButton.styleFrom(
                  backgroundColor: context.appColors.brand,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: Theme.of(context).brightness == Brightness.light
                      ? 6
                      : 0,
                  shadowColor: context.appColors.brand.withValues(alpha: 0.4),
                ),
                child: const Text('View Full Zone Report →'),
              ),
            ],
          ),
        );
      },
    );
  }
}
