import 'package:flutter/material.dart';

import 'app_color_tokens.dart';

/// Convenience accessors for app theme tokens.
extension ThemeContextX on BuildContext {
  AppColorTokens get appColors => Theme.of(this).extension<AppColorTokens>()!;
}

