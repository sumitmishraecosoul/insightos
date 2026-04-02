
import 'package:insightos/core/utils/number_formatters.dart';

class MetricFormatter {
  static String format({
    required String label,
    required num value,
    String? unit,
  }) {
    final l = label.toLowerCase();

    if (unit == 'Rs' || l == 'spend' || l == 'gmv' || l == 'cac') {
      return NumberFormatters.compactRs(value);
    }

    if (unit == '%' || l.contains('rate') || l == 'ctr' || l == 'replies') {
      return '${NumberFormatters.fixed(value, decimals: 2)}%';
    }

    if (label.toUpperCase() == 'ROAS') {
      return '${NumberFormatters.fixed(value, decimals: 2)}×';
    }

    if (value.abs() >= 100000) {
      return NumberFormatters.compactInr(value, decimals: 2);
    }

    if (value.abs() >= 1000) {
      return NumberFormatters.compactInr(value, decimals: 1);
    }

    return value.toString();
  }
}