import 'package:flutter/foundation.dart';

import 'primary_metric.dart';
import 'zone_metric.dart';

/// A marketing performance zone (e.g. Paid Ads, SEO).
@immutable
class Zone {
  const Zone({
    required this.id,
    required this.name,
    required this.primaryMetric,
    required this.metrics,
    required this.trend4w,
  });

  final String id;
  final String name;
  final PrimaryMetric primaryMetric;
  final List<ZoneMetric> metrics;

  /// Four-week trend values for the sparkline.
  final List<num> trend4w;

  factory Zone.fromJson(Map<String, Object?> json) {
    return Zone(
      id: json['id'] as String,
      name: json['name'] as String,
      primaryMetric:
          PrimaryMetric.fromJson(json['primary_metric'] as Map<String, Object?>),
      metrics: (json['metrics'] as List<Object?>)
          .cast<Map<String, Object?>>()
          .map(ZoneMetric.fromJson)
          .toList(growable: false),
      trend4w: (json['trend_4w'] as List<Object?>?)
              ?.map((e) => e as num)
              .toList(growable: false) ??
          const <num>[],
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'name': name,
      'primary_metric': primaryMetric.toJson(),
      'metrics': metrics.map((m) => m.toJson()).toList(growable: false),
      'trend_4w': trend4w,
    };
  }
}

