import 'package:flutter/foundation.dart';

/// A labeled metric value for a given zone.
@immutable
class ZoneMetric {
  const ZoneMetric({
    required this.label,
    required this.value,
    this.unit,
  });

  final String label;
  final num value;
  final String? unit;

  factory ZoneMetric.fromJson(Map<String, Object?> json) {
    return ZoneMetric(
      label: json['label'] as String,
      value: json['value'] as num,
      unit: json['unit'] as String?,
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'label': label,
      'value': value,
      if (unit != null) 'unit': unit,
    };
  }
}

