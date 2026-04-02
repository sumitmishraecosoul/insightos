import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color_tokens.dart';

/// Application themes and theme tokens.
abstract final class AppTheme {
  static const PageTransitionsTheme _pageTransitions = PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
    },
  );

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColorTokens.light.brand),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColorTokens.light.surfaceAlt,
      pageTransitionsTheme: _pageTransitions,
      brightness: Brightness.light,
      textTheme: _textTheme(AppColorTokens.light, Brightness.light),
      extensions: const <ThemeExtension<dynamic>>[AppColorTokens.light],
      cardTheme: CardThemeData(
        color: AppColorTokens.light.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColorTokens.light.border),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorTokens.light.surface,
        surfaceTintColor: AppColorTokens.light.surface,
        foregroundColor: AppColorTokens.light.textPrimary,
        elevation: 0,
      ),
    );
  }

  static ThemeData dark() {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorTokens.dark.brand,
        brightness: Brightness.dark,
      ),
    );

    return base.copyWith(
      scaffoldBackgroundColor: AppColorTokens.dark.surfaceAlt,
      pageTransitionsTheme: _pageTransitions,
      textTheme: _textTheme(AppColorTokens.dark, Brightness.dark),
      extensions: const <ThemeExtension<dynamic>>[AppColorTokens.dark],
      cardTheme: CardThemeData(
        color: AppColorTokens.dark.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColorTokens.dark.border),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorTokens.dark.surface,
        surfaceTintColor: AppColorTokens.dark.surface,
        foregroundColor: AppColorTokens.dark.textPrimary,
        elevation: 0,
      ),
    );
  }

  static TextTheme _textTheme(AppColorTokens tokens, Brightness brightness) {
    final base = ThemeData(brightness: brightness).textTheme;
    return base.copyWith(
      displaySmall: GoogleFonts.syne(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: tokens.textPrimary,
      ),
      titleLarge: GoogleFonts.syne(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: tokens.textPrimary,
      ),
      titleMedium: GoogleFonts.syne(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: tokens.textPrimary,
      ),
      titleSmall: GoogleFonts.syne(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: tokens.textPrimary,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: tokens.textPrimary,
      ),
      bodySmall: GoogleFonts.dmSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: tokens.textSecondary,
      ),
      labelLarge: GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
        color: tokens.textTertiary,
      ),
      labelMedium: GoogleFonts.dmSans(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: tokens.textSecondary,
      ),
      labelSmall: GoogleFonts.dmSans(
        fontSize: 9,
        fontWeight: FontWeight.w600,
        color: tokens.textTertiary,
      ),
    );
  }
}
