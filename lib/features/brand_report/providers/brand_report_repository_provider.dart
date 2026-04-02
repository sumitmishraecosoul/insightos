import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/brand_report_repository.dart';
import '../../../data/repositories/fake_brand_report_repository.dart';

/// Failure rate used by mock API to simulate network errors.
final mockFailureRateProvider = StateProvider<double>((ref) => 0.0);

/// Repository provider for Brand Report
final brandReportRepositoryProvider = Provider<BrandReportRepository>((ref) {
  final failureRate = ref.watch(mockFailureRateProvider);

  return FakeBrandReportRepository(
    failureRate: failureRate,
  );
});