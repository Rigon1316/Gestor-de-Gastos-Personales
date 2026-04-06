import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color bg;
  final Color surface;
  final Color card;
  final Color accent;
  final Color accent2;
  final Color prim;
  final Color sec;
  final Color div;

  const AppColors({
    required this.bg,
    required this.surface,
    required this.card,
    required this.accent,
    required this.accent2,
    required this.prim,
    required this.sec,
    required this.div,
  });

  @override
  AppColors copyWith({
    Color? bg,
    Color? surface,
    Color? card,
    Color? accent,
    Color? accent2,
    Color? prim,
    Color? sec,
    Color? div,
  }) {
    return AppColors(
      bg: bg ?? this.bg,
      surface: surface ?? this.surface,
      card: card ?? this.card,
      accent: accent ?? this.accent,
      accent2: accent2 ?? this.accent2,
      prim: prim ?? this.prim,
      sec: sec ?? this.sec,
      div: div ?? this.div,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      card: Color.lerp(card, other.card, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accent2: Color.lerp(accent2, other.accent2, t)!,
      prim: Color.lerp(prim, other.prim, t)!,
      sec: Color.lerp(sec, other.sec, t)!,
      div: Color.lerp(div, other.div, t)!,
    );
  }
}

// Extension to easily access colors: context.colors.bg
extension AppThemeExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

class AppTheme {
  static final AppColors _darkColors = const AppColors(
    bg: Color(0xFF0A0E1A),
    surface: Color(0xFF131929),
    card: Color(0xFF1C2437),
    accent: Color(0xFF6C63FF),
    accent2: Color(0xFF00D2FF),
    prim: Color(0xFFECEFF4),
    sec: Color(0xFF8892A4),
    div: Color(0xFF1E2A3A),
  );

  static final AppColors _lightColors = const AppColors(
    bg: Color(0xFFF3F4F6),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    accent: Color(0xFF6C63FF), // Keep purple accent
    accent2: Color(0xFF00D2FF),
    prim: Color(0xFF111827), // Dark text
    sec: Color(0xFF6B7280), // Gray text
    div: Color(0xFFE5E7EB), // Light gray divider
  );

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _darkColors.bg,
      colorScheme: ColorScheme.dark(
        primary: _darkColors.accent,
        secondary: _darkColors.accent2,
        surface: _darkColors.surface,
      ),
      extensions: [_darkColors],
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: _lightColors.bg,
      colorScheme: ColorScheme.light(
        primary: _lightColors.accent,
        secondary: _lightColors.accent2,
        surface: _lightColors.surface,
      ),
      extensions: [_lightColors],
    );
  }
}
