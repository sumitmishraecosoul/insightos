import 'package:flutter/foundation.dart';

/// Insight type for the AI insights feed.
enum InsightType {
  /// Attention required / negative change.
  alert,

  /// Positive change / potential upside.
  opportunity,

  /// Informational.
  fyi,
}

/// AI-generated insight item shown in the insights feed.
@immutable
class Insight {
  const Insight({
    required this.id,
    required this.zoneId,
    required this.type,
    required this.headline,
    required this.body,
    required this.isUrgent,
  });

  final String id;
  final String zoneId;
  final InsightType type;
  final String headline;
  final String body;
  final bool isUrgent;

  factory Insight.fromJson(Map<String, Object?> json) {
    return Insight(
      id: json['id'] as String,
      zoneId: json['zone_id'] as String,
      type: _insightTypeFromJson(json['type'] as String),
      headline: json['headline'] as String,
      body: json['body'] as String,
      isUrgent: (json['is_urgent'] as bool?) ?? false,
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'zone_id': zoneId,
      'type': type.name,
      'headline': headline,
      'body': body,
      'is_urgent': isUrgent,
    };
  }

  static InsightType _insightTypeFromJson(String raw) {
    return switch (raw) {
      'alert' => InsightType.alert,
      'opportunity' => InsightType.opportunity,
      'fyi' => InsightType.fyi,
      _ => InsightType.fyi,
    };
  }
}

