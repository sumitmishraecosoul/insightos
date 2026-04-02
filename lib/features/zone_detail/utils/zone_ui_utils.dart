import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class ZoneUIUtils {
  static String trendLine(String trend, num changePct) {
    final arrow = switch (trend) {
      'up' => '▲',
      'down' => '▼',
      _ => '→',
    };
    return '$arrow ${changePct.abs().toStringAsFixed(1)}% vs last week';
  }

  static Color trendColor(BuildContext context, String trend) {
    return switch (trend) {
      'up' => context.appColors.success,
      'down' => context.appColors.danger,
      _ => context.appColors.textTertiary,
    };
  }
}