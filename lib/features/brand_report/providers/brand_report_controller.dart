import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/brand_report.dart';
import 'brand_report_repository_provider.dart';

class BrandReportController extends AsyncNotifier<BrandReport> {
  @override
  Future<BrandReport> build() async {
    return _fetchReport();
  }

  /// Core API call
  Future<BrandReport> _fetchReport() async {
    final repo = ref.read(brandReportRepositoryProvider);
    return repo.fetchBrandReport();
  }

  /// Refresh data
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchReport);
  }
}