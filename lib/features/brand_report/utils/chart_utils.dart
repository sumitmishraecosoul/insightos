class ChartUtils {
  static double normalize(double value, double min, double max) {
    final denom = (max - min).abs() < 0.000001 ? 1 : (max - min);
    return (value - min) / denom;
  }

  static double min(List<num> values) {
    return values.reduce((a, b) => a < b ? a : b).toDouble();
  }

  static double max(List<num> values) {
    return values.reduce((a, b) => a > b ? a : b).toDouble();
  }
}