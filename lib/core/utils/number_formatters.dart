import 'package:intl/intl.dart';

/// Shared formatting helpers for UI.
abstract final class NumberFormatters {
  static final NumberFormat _inrCommas = NumberFormat.decimalPattern('en_IN');

  /// Adds comma separators using Indian grouping (e.g. 178000 -> 1,78,000).
  static String commas(num value) => _inrCommas.format(value);

  /// Compact INR style without the currency symbol (e.g. 178000 -> 1.78L).
  ///
  /// Uses Lakhs (L) and Crores (Cr) common in India.
  static String compactInr(num value, {int decimals = 2}) {
    final v = value.toDouble();
    if (v.abs() >= 10000000) return '${(v / 10000000).toStringAsFixed(decimals)}Cr';
    if (v.abs() >= 100000) return '${(v / 100000).toStringAsFixed(decimals)}L';
    if (v.abs() >= 1000) return '${(v / 1000).toStringAsFixed(decimals)}K';
    return v.toStringAsFixed(0);
  }

  /// Compact INR with symbol prefix (e.g. 178000 -> ₹1.78L).
  static String compactRs(num value, {int decimals = 2}) {
    return '₹${compactInr(value, decimals: decimals)}';
  }

  /// Fixed decimals trimming noise (e.g. 0.823423 -> 0.82).
  static String fixed(num value, {int decimals = 2}) {
    return value.toDouble().toStringAsFixed(decimals);
  }
}

