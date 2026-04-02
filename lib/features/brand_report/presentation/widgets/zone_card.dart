import 'package:flutter/material.dart';
import 'package:insightos/core/utils/number_formatters.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../data/models/zone.dart';

/// Zone summary card shown in the dashboard.
class ZoneCard extends StatelessWidget {
  const ZoneCard({
    super.key,
    required this.zone,
    required this.onTap,
    required this.isActive,
  });

  final Zone zone;
  final VoidCallback onTap;
  final bool isActive;

  static const double _radius = 14;

  @override
  Widget build(BuildContext context) {
    final pm = zone.primaryMetric;
    final trendColor = _trendColor(context, pm.trend);
    final changeText = _formatPct(pm.changePct);
    final arrow = _trendArrow(pm.trend);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(_radius),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: isActive
                ? context.appColors.brandBg
                : context.appColors.cardAlt,
            borderRadius: BorderRadius.circular(_radius),
            border: Border.all(
              color: isActive
                  ? context.appColors.brand
                  : context.appColors.border,
            ),
            boxShadow:
                isActive && Theme.of(context).brightness == Brightness.light
                ? [
                    BoxShadow(
                      color: context.appColors.brand.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  zone.name,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: context.appColors.textSecondary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  pm.label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: context.appColors.textTertiary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  _formatMetricValue(pm.label, pm.value),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: context.appColors.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      arrow,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: trendColor),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      changeText,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: trendColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatPct(num pct) {
    final sign = pct > 0 ? '+' : '';
    return '$sign${pct.toStringAsFixed(1)}%';
  }

  String _trendArrow(String trend) {
    return switch (trend) {
      'up' => '▲',
      'down' => '▼',
      _ => '→',
    };
  }

  Color _trendColor(BuildContext context, String trend) {
    return switch (trend) {
      'up' => context.appColors.success,
      'down' => context.appColors.danger,
      _ => context.appColors.textTertiary,
    };
  }

  String _formatMetricValue(String label, num value) {
    if (label.toUpperCase() == 'ROAS') return '${value.toStringAsFixed(1)}×';
    if (label.toLowerCase() == 'spend')
      return NumberFormatters.compactRs(value);
    return value.toString();
  }
}
