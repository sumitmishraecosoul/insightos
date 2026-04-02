import 'dart:async';
import 'dart:math';

import '../../core/utils/app_logger.dart';
import '../models/brand_report.dart';
import 'brand_report_repository.dart';

/// Local mock API that returns a JSON-like payload after an artificial delay.
class FakeBrandReportRepository implements BrandReportRepository {
  FakeBrandReportRepository({
    Duration? delay,
    double? failureRate,
    int? seed,
  })  : _delay = delay ?? const Duration(milliseconds: 500),
        _failureRate = failureRate ?? 0,
        _rng = Random(seed);

  final Duration _delay;
  final double _failureRate;
  final Random _rng;

  @override
  Future<BrandReport> fetchBrandReport() async {
    await Future<void>.delayed(_delay);

    if (_failureRate > 0 && _rng.nextDouble() < _failureRate) {
      appLogger.w('Simulated network failure in FakeBrandReportRepository.');
      throw TimeoutException('Simulated network timeout');
    }

    final payload = _buildPayload();
    return BrandReport.fromJson(payload);
  }

  Map<String, Object?> _buildPayload() {
    return <String, Object?>{
      'brand_health_score': 74,
      'zones': <Map<String, Object?>>[
        _zonePaidAds(),
        _zoneSeo(),
        _zoneSocial(),
        _zoneMarketplace(),
        _zoneMessaging(),
      ],
      'weekly_spend': <num>[
        120000,
        145000,
        132000,
        168000,
        155000,
        178000,
        162000,
        190000,
      ],
      'weekly_roas': <num>[3.8, 4.1, 3.9, 4.4, 4.2, 4.7, 4.3, 4.9],
      'insights': <Map<String, Object?>>[
        <String, Object?>{
          'id': 'i_urgent_paid_ads',
          'zone_id': 'paid_ads',
          'type': 'alert',
          'headline': 'Paid Ads CAC spiked this week',
          'body':
              'CAC increased by 18% WoW while CTR stayed flat. Consider pausing low-performing ad sets.',
          'is_urgent': true,
        },
        <String, Object?>{
          'id': 'i_seo_opportunity',
          'zone_id': 'seo',
          'type': 'opportunity',
          'headline': 'SEO rankings improving for 6 keywords',
          'body':
              'Average position improved by 3.2. Refresh top landing pages to capitalize on the momentum.',
          'is_urgent': false,
        },
        <String, Object?>{
          'id': 'i_marketplace_fyi',
          'zone_id': 'marketplace',
          'type': 'fyi',
          'headline': 'Marketplace impressions up, conversions steady',
          'body':
              'Impressions increased 12% but conversion rate is unchanged. Check PDP content and reviews.',
          'is_urgent': false,
        },
      ],
      'channel_mix': <String, num>{
        'paid_social': 42,
        'marketplace': 20,
        'influencer': 14,
        'seo': 12,
        'others': 12,
      },
    };
  }

  Map<String, Object?> _zonePaidAds() {
    return <String, Object?>{
      'id': 'paid_ads',
      'name': 'Paid Ads',
      'primary_metric': <String, Object?>{
        'label': 'ROAS',
        'value': 4.2,
        'change_pct': 8.3,
        'trend': 'up',
      },
      'trend_4w': <num>[3.7, 3.9, 4.1, 4.2],
      'metrics': <Map<String, Object?>>[
        <String, Object?>{'label': 'Spend', 'value': 178000, 'unit': 'Rs'},
        <String, Object?>{'label': 'ROAS', 'value': 4.2},
        <String, Object?>{'label': 'CTR', 'value': 1.7, 'unit': '%'},
        <String, Object?>{'label': 'Impressions', 'value': 220000},
        <String, Object?>{'label': 'CAC', 'value': 690, 'unit': 'Rs'},
      ],
    };
  }

  Map<String, Object?> _zoneSeo() {
    return <String, Object?>{
      'id': 'seo',
      'name': 'SEO',
      'primary_metric': <String, Object?>{
        'label': 'DA',
        'value': 41,
        'change_pct': 2.1,
        'trend': 'up',
      },
      'trend_4w': <num>[38, 39, 40, 41],
      'metrics': <Map<String, Object?>>[
        <String, Object?>{'label': 'DA', 'value': 41},
        <String, Object?>{'label': 'Organic sessions', 'value': 54000},
        <String, Object?>{'label': 'Top 10 keywords', 'value': 18},
        <String, Object?>{'label': 'CTR', 'value': 3.4, 'unit': '%'},
      ],
    };
  }

  Map<String, Object?> _zoneSocial() {
    return <String, Object?>{
      'id': 'social_media',
      'name': 'Social Media',
      'primary_metric': <String, Object?>{
        'label': 'Engagement',
        'value': 6.8,
        'change_pct': -3.2,
        'trend': 'down',
      },
      'trend_4w': <num>[7.4, 7.0, 6.9, 6.8],
      'metrics': <Map<String, Object?>>[
        <String, Object?>{'label': 'Reach', 'value': 320000},
        <String, Object?>{'label': 'Engagement', 'value': 6.8, 'unit': '%'},
        <String, Object?>{'label': 'Followers', 'value': 124000},
      ],
    };
  }

  Map<String, Object?> _zoneMarketplace() {
    return <String, Object?>{
      'id': 'marketplace',
      'name': 'Marketplace',
      'primary_metric': <String, Object?>{
        'label': 'Sales',
        'value': 32.4,
        'change_pct': 4.5,
        'trend': 'up',
      },
      'trend_4w': <num>[30.1, 31.2, 31.8, 32.4],
      'metrics': <Map<String, Object?>>[
        <String, Object?>{'label': 'GMV', 'value': 980000, 'unit': 'Rs'},
        <String, Object?>{'label': 'Orders', 'value': 1820},
        <String, Object?>{'label': 'Return rate', 'value': 3.1, 'unit': '%'},
      ],
    };
  }

  Map<String, Object?> _zoneMessaging() {
    return <String, Object?>{
      'id': 'messaging',
      'name': 'Messaging',
      'primary_metric': <String, Object?>{
        'label': 'Replies',
        'value': 24.1,
        'change_pct': 0.0,
        'trend': 'flat',
      },
      'trend_4w': <num>[23.8, 24.0, 24.2, 24.1],
      'metrics': <Map<String, Object?>>[
        <String, Object?>{'label': 'Sent', 'value': 42000},
        <String, Object?>{'label': 'Replies', 'value': 24.1, 'unit': '%'},
        <String, Object?>{'label': 'Opt-outs', 'value': 1.2, 'unit': '%'},
      ],
    };
  }
}

