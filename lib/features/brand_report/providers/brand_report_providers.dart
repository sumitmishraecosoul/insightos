import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/brand_report.dart';
import 'brand_report_controller.dart';

/// Main provider used in UI
final brandReportControllerProvider =
    AsyncNotifierProvider<BrandReportController, BrandReport>(
      BrandReportController.new,
    );
