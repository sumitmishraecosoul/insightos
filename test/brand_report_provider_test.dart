import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insightos/data/models/brand_report.dart';
import 'package:insightos/data/repositories/brand_report_repository.dart';
import 'package:insightos/features/brand_report/providers/brand_report_providers.dart';
import 'package:insightos/features/brand_report/providers/brand_report_repository_provider.dart';

class _SuccessRepo implements BrandReportRepository {
  _SuccessRepo(this.report);
  final BrandReport report;

  @override
  Future<BrandReport> fetchBrandReport() async => report;
}

class _FailRepo implements BrandReportRepository {
  @override
  Future<BrandReport> fetchBrandReport() async => throw Exception('fail');
}

void main() {
  test('brandReportProvider emits data when repository succeeds', () async {
    const report = BrandReport(
      brandHealthScore: 74,
      zones: [],
      weeklySpend: [1, 2, 3, 4, 5, 6, 7, 8],
      weeklyRoas: [1, 1, 1, 1, 1, 1, 1, 1],
      insights: [],
      channelMix: {'others': 100},
    );

    final container = ProviderContainer(
      overrides: [
        brandReportRepositoryProvider.overrideWithValue(_SuccessRepo(report)),
      ],
    );
    addTearDown(container.dispose);

    final value = await container.read(brandReportControllerProvider.future);
    expect(value.brandHealthScore, 74);
  });

  test('brandReportProvider emits error when repository fails', () async {
    final container = ProviderContainer(
      overrides: [
        brandReportRepositoryProvider.overrideWithValue(_FailRepo()),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(brandReportControllerProvider.future), throwsA(isA<Exception>()));
  });
}

