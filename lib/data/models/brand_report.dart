import 'package:flutter/foundation.dart';

import 'insight.dart';
import 'zone.dart';

/// Brand report payload powering the dashboard.
@immutable
class BrandReport {
  const BrandReport({
    required this.brandHealthScore,
    required this.zones,
    required this.weeklySpend,
    required this.weeklyRoas,
    required this.insights,
    required this.channelMix,
  });

  final int brandHealthScore;
  final List<Zone> zones;
  final List<num> weeklySpend;
  final List<num> weeklyRoas;
  final List<Insight> insights;

  /// Percentage split by channel key (must sum ~100).
  final Map<String, num> channelMix;

  factory BrandReport.fromJson(Map<String, Object?> json) {
    return BrandReport(
      brandHealthScore: json['brand_health_score'] as int,
      zones: (json['zones'] as List<Object?>)
          .cast<Map<String, Object?>>()
          .map(Zone.fromJson)
          .toList(growable: false),
      weeklySpend: (json['weekly_spend'] as List<Object?>)
          .map((e) => e as num)
          .toList(growable: false),
      weeklyRoas: (json['weekly_roas'] as List<Object?>)
          .map((e) => e as num)
          .toList(growable: false),
      insights: (json['insights'] as List<Object?>)
          .cast<Map<String, Object?>>()
          .map(Insight.fromJson)
          .toList(growable: false),
      channelMix: (json['channel_mix'] as Map<String, Object?>).map(
        (k, v) => MapEntry(k, v as num),
      ),
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'brand_health_score': brandHealthScore,
      'zones': zones.map((z) => z.toJson()).toList(growable: false),
      'weekly_spend': weeklySpend,
      'weekly_roas': weeklyRoas,
      'insights': insights.map((i) => i.toJson()).toList(growable: false),
      'channel_mix': channelMix,
    };
  }
}

