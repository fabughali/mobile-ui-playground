import 'package:flutter/material.dart';

/// Defines all available colors used in the app with semantic names
class ColorsList {
  // Primary Brand Colors
  static const Color primary = Color(0xFF6750A4);
  static const Color primaryLight = Color(0xFFD0BCFF);
  static const Color primaryDark = Color(0xFF4F378B);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF625B71);
  static const Color secondaryLight = Color(0xFFCCC2DC);
  static const Color secondaryDark = Color(0xFF4A4458);
  
  // Accent Colors
  static const Color accent = Color(0xFF7D5260);
  static const Color accentLight = Color(0xFFEFB8C8);
  static const Color accentDark = Color(0xFF633B48);
  
  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);
  
  // Warning Colors
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);
  
  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorLight = Color(0xFFFFB4AB);
  static const Color errorDark = Color(0xFF93000A);
  
  // Info Colors
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  
  // Gray Scale
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);
  
  // Background Colors
  static const Color backgroundLight = Color(0xFFFFFBFE);
  static const Color backgroundDark = Color(0xFF1C1B1F);
  static const Color surfaceLight = Color(0xFFFFFBFE);
  static const Color surfaceDark = Color(0xFF1C1B1F);
  
  // Surface Variants
  static const Color surfaceVariantLight = Color(0xFFE7E0EC);
  static const Color surfaceVariantDark = Color(0xFF49454F);
  
  // Outline Colors
  static const Color outlineLight = Color(0xFF79747E);
  static const Color outlineDark = Color(0xFF938F99);
}

/// App-wide color scheme using semantic color assignments
class AppColors {
  // Theme-based color getters
  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: ColorsList.primary,
    onPrimary: ColorsList.white,
    primaryContainer: Color(0xFFEADDFF),
    onPrimaryContainer: Color(0xFF21005D),
    secondary: ColorsList.secondary,
    onSecondary: ColorsList.white,
    secondaryContainer: Color(0xFFE8DEF8),
    onSecondaryContainer: Color(0xFF1D192B),
    tertiary: ColorsList.accent,
    onTertiary: ColorsList.white,
    tertiaryContainer: Color(0xFFFFD8E4),
    onTertiaryContainer: Color(0xFF31111D),
    error: ColorsList.error,
    onError: ColorsList.white,
    errorContainer: Color(0xFFFFDAD6),
    onErrorContainer: Color(0xFF410002),
    surface: ColorsList.surfaceLight,
    onSurface: Color(0xFF1C1B1F),
    surfaceContainerHighest: ColorsList.surfaceVariantLight,
    onSurfaceVariant: Color(0xFF49454F),
    outline: ColorsList.outlineLight,
    outlineVariant: Color(0xFFCAC4D0),
    shadow: ColorsList.black,
    scrim: ColorsList.black,
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: ColorsList.primaryLight,
    surfaceTint: ColorsList.primary,
  );

  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: ColorsList.primaryLight,
    onPrimary: Color(0xFF381E72),
    primaryContainer: ColorsList.primaryDark,
    onPrimaryContainer: Color(0xFFEADDFF),
    secondary: ColorsList.secondaryLight,
    onSecondary: Color(0xFF332D41),
    secondaryContainer: ColorsList.secondaryDark,
    onSecondaryContainer: Color(0xFFE8DEF8),
    tertiary: ColorsList.accentLight,
    onTertiary: Color(0xFF492532),
    tertiaryContainer: ColorsList.accentDark,
    onTertiaryContainer: Color(0xFFFFD8E4),
    error: ColorsList.errorLight,
    onError: Color(0xFF690005),
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: ColorsList.surfaceDark,
    onSurface: Color(0xFFE6E1E5),
    surfaceContainerHighest: ColorsList.surfaceVariantDark,
    onSurfaceVariant: Color(0xFFCAC4D0),
    outline: ColorsList.outlineDark,
    outlineVariant: Color(0xFF49454F),
    shadow: ColorsList.black,
    scrim: ColorsList.black,
    inverseSurface: Color(0xFFE6E1E5),
    onInverseSurface: Color(0xFF313033),
    inversePrimary: ColorsList.primary,
    surfaceTint: ColorsList.primaryLight,
  );

  // Semantic color assignments
  static const Color defaultTitleColor = ColorsList.white;
  static const Color defaultBackgroundColor = ColorsList.gray100;
  static const Color defaultAppBarColor = ColorsList.primary;
  static const Color defaultButtonColor = ColorsList.success;
  static const Color defaultCardColor = ColorsList.white;
  static const Color defaultShadowColor = ColorsList.black;
  static const Color defaultFontColor = ColorsList.gray900;
  
  // Status colors
  static const Color successColor = ColorsList.success;
  static const Color warningColor = ColorsList.warning;
  static const Color errorColor = ColorsList.error;
  static const Color infoColor = ColorsList.info;
  
  // UI element colors
  static const Color cardBackground = ColorsList.white;
  static const Color textPrimary = ColorsList.gray900;
  static const Color textSecondary = ColorsList.gray600;
  static const Color textDisabled = ColorsList.gray400;
  
  // Interactive colors
  static const Color buttonPrimary = ColorsList.primary;
  static const Color buttonSecondary = ColorsList.secondary;
  static const Color buttonSuccess = ColorsList.success;
  static const Color buttonWarning = ColorsList.warning;
  static const Color buttonError = ColorsList.error;
  
  // Border and divider colors
  static const Color borderLight = ColorsList.gray200;
  static const Color borderMedium = ColorsList.gray300;
  static const Color borderDark = ColorsList.gray400;
  
  // Shadow colors
  static const Color shadowLight = Color(0x1A000000); // 10% opacity
  static const Color shadowMedium = Color(0x33000000); // 20% opacity
  static const Color shadowDark = Color(0x66000000); // 40% opacity
  
  // Gradient definitions
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorsList.primary, ColorsList.primaryLight],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorsList.secondary, ColorsList.secondaryLight],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorsList.accent, ColorsList.accentLight],
  );
  
  // Background gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [ColorsList.backgroundLight, ColorsList.gray100],
  );
  
  // Utility methods
  static Color withOpacity(Color color, double opacity) {
    return color.withAlpha((opacity * 255).round());
  }
  
  static Color getRandomColor() {
    final colors = [
      ColorsList.primary,
      ColorsList.secondary,
      ColorsList.accent,
      ColorsList.success,
      ColorsList.warning,
      ColorsList.info,
    ];
    return colors[DateTime.now().millisecond % colors.length];
  }
}
