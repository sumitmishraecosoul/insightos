import 'package:flutter_test/flutter_test.dart';
import 'package:insightos/data/repositories/fake_brand_report_repository.dart';

void main() {
  test('FakeBrandReportRepository returns a valid payload', () async {
    final repo = FakeBrandReportRepository(delay: Duration.zero, failureRate: 0);
    final report = await repo.fetchBrandReport();

    expect(report.brandHealthScore, inInclusiveRange(0, 100));
    expect(report.zones, isNotEmpty);
    expect(report.weeklySpend.length, 8);
    expect(report.weeklyRoas.length, 8);
    expect(report.insights.length, greaterThanOrEqualTo(3));
    expect(report.channelMix, isNotEmpty);
  });

  test('FakeBrandReportRepository can simulate failures', () async {
    final repo = FakeBrandReportRepository(delay: Duration.zero, failureRate: 1, seed: 1);
    expect(repo.fetchBrandReport(), throwsA(isA<Exception>()));
  });
}

