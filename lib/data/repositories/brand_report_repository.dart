import '../models/brand_report.dart';

/// Repository contract for fetching the brand report.
abstract interface class BrandReportRepository {
  /// Fetch the latest report payload.
  Future<BrandReport> fetchBrandReport();
}

