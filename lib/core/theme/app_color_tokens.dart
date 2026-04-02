import 'package:flutter/material.dart';

/// Semantic color tokens used across the app.
///
/// Widgets should prefer these tokens over hardcoded colors.
@immutable
class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.brand,
    required this.purple,
    required this.success,
    required this.warning,
    required this.danger,
    required this.brandBg,
    required this.successBg,
    required this.warningBg,
    required this.dangerBg,
    required this.surface,
    required this.surfaceAlt,
    required this.card,
    required this.cardAlt,
    required this.border,
    required this.borderStrong,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
  });

  final Color brand;
  final Color purple;
  final Color success;
  final Color warning;
  final Color danger;

  final Color brandBg;
  final Color successBg;
  final Color warningBg;
  final Color dangerBg;

  final Color surface;
  final Color surfaceAlt;
  final Color card;
  final Color cardAlt;
  final Color border;
  final Color borderStrong;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  static const light = AppColorTokens(
    brand: Color(0xFF2563EB),
    purple: Color(0xFF6B3FD4),
    success: Color(0xFF0F8A5A),
    warning: Color(0xFFB86A00),
    danger: Color(0xFFD0362A),
    brandBg: Color(0xFFEEF3FD),
    successBg: Color(0xFFE6F7EF),
    warningBg: Color(0xFFFFF4E0),
    dangerBg: Color(0xFFFDF0EE),
    surface: Color(0xFFFFFFFF),
    surfaceAlt: Color(0xFFF5F4F0),
    card: Color(0xFFFFFFFF),
    cardAlt: Color(0xFFF9F8F5),
    border: Color(0xFFE0DED8),
    borderStrong: Color(0xFFCCCAC3),
    textPrimary: Color(0xFF1A1A1F),
    textSecondary: Color(0xFF5A5A6E),
    textTertiary: Color(0xFF9696A8),
  );

  static const dark = AppColorTokens(
    brand: Color(0xFF5B8FF9),
    purple: Color(0xFF9B6FF9),
    success: Color(0xFF2DD98F),
    warning: Color(0xFFF6A623),
    danger: Color(0xFFF05252),
    brandBg: Color(0xFF0F1A35),
    successBg: Color(0xFF0D2B1F),
    warningBg: Color(0xFF2B1E0A),
    dangerBg: Color(0xFF2B0F0F),
    surface: Color(0xFF131620),
    surfaceAlt: Color(0xFF0D0F14),
    card: Color(0xFF191C27),
    cardAlt: Color(0xFF1E2132),
    border: Color(0xFF2A2F45),
    borderStrong: Color(0xFF333856),
    textPrimary: Color(0xFFE8EAF2),
    textSecondary: Color(0xFF9BA3C4),
    textTertiary: Color(0xFF5A6285),
  );

  @override
  AppColorTokens copyWith({
    Color? brand,
    Color? purple,
    Color? success,
    Color? warning,
    Color? danger,
    Color? brandBg,
    Color? successBg,
    Color? warningBg,
    Color? dangerBg,
    Color? surface,
    Color? surfaceAlt,
    Color? card,
    Color? cardAlt,
    Color? border,
    Color? borderStrong,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
  }) {
    return AppColorTokens(
      brand: brand ?? this.brand,
      purple: purple ?? this.purple,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      brandBg: brandBg ?? this.brandBg,
      successBg: successBg ?? this.successBg,
      warningBg: warningBg ?? this.warningBg,
      dangerBg: dangerBg ?? this.dangerBg,
      surface: surface ?? this.surface,
      surfaceAlt: surfaceAlt ?? this.surfaceAlt,
      card: card ?? this.card,
      cardAlt: cardAlt ?? this.cardAlt,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
    );
  }

  @override
  ThemeExtension<AppColorTokens> lerp(
    ThemeExtension<AppColorTokens>? other,
    double t,
  ) {
    if (other is! AppColorTokens) return this;
    return AppColorTokens(
      brand: Color.lerp(brand, other.brand, t)!,
      purple: Color.lerp(purple, other.purple, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      brandBg: Color.lerp(brandBg, other.brandBg, t)!,
      successBg: Color.lerp(successBg, other.successBg, t)!,
      warningBg: Color.lerp(warningBg, other.warningBg, t)!,
      dangerBg: Color.lerp(dangerBg, other.dangerBg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceAlt: Color.lerp(surfaceAlt, other.surfaceAlt, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardAlt: Color.lerp(cardAlt, other.cardAlt, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
    );
  }
}
