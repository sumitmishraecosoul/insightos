import 'package:flutter/foundation.dart';

/// The headline metric shown on a zone card.
@immutable
class PrimaryMetric {
  const PrimaryMetric({
    required this.label,
    required this.value,
    required this.changePct,
    required this.trend,
  });

  final String label;
  final num value;
  final num changePct;

  /// One of: up / down / flat.
  final String trend;

  factory PrimaryMetric.fromJson(Map<String, Object?> json) {
    return PrimaryMetric(
      label: json['label'] as String,
      value: json['value'] as num,
      changePct: json['change_pct'] as num,
      trend: (json['trend'] as String?) ?? 'flat',
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'label': label,
      'value': value,
      'change_pct': changePct,
      'trend': trend,
    };
  }
}

