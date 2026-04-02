import 'package:flutter/widgets.dart';

/// Central spacing scale used throughout the UI.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double x2l = 24;
  static const double x3l = 32;

  static const EdgeInsets screenPadding = EdgeInsets.all(lg);
}

