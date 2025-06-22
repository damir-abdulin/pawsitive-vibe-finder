import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_constants.dart';

/// A class that holds the theme data for the application.
class AppTheme {
  /// The light theme for the application.
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primaryBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBackground,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      shadowColor: Colors.black12,
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.textPrimary,
        fontSize: AppConstants.largeFontSize,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      error: AppColors.error,
      onSurface: AppColors.textPrimary,
      surface: AppColors.primaryBackground,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textPrimary),
      bodyMedium: TextStyle(color: AppColors.textSecondary),
      titleLarge: TextStyle(
        color: AppColors.textPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondaryBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.smallBorderRadius),
        borderSide: const BorderSide(
          color: AppColors.accent,
          width: AppConstants.thickBorder,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: AppConstants.extraSmallPadding + AppConstants.smallPadding,
        horizontal: AppConstants.mediumPadding,
      ),
      hintStyle: const TextStyle(color: AppColors.textSecondary),
    ),
  );

  /// The beautiful dark theme for the application.
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryDarkTheme,
    scaffoldBackgroundColor: AppColors.darkPrimaryBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSecondaryBackground,
      foregroundColor: AppColors.darkTextPrimary,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
      titleTextStyle: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDarkTheme,
      onPrimary: AppColors.darkTextPrimary,
      secondary: AppColors.accentDark,
      onSecondary: AppColors.darkTextPrimary,
      tertiary: AppColors.darkAccentGradientStart,
      onTertiary: AppColors.darkTextPrimary,
      error: AppColors.errorDark,
      onError: AppColors.darkTextPrimary,
      surface: AppColors.darkSecondaryBackground,
      onSurface: AppColors.darkTextPrimary,
      surfaceContainerHighest: AppColors.darkSurfaceBackground,
      onSurfaceVariant: AppColors.darkTextSecondary,
      outline: AppColors.darkBorder,
      outlineVariant: AppColors.darkDivider,
      shadow: Colors.black54,
      scrim: Colors.black87,
      inverseSurface: AppColors.darkTextPrimary,
      onInverseSurface: AppColors.darkPrimaryBackground,
      inversePrimary: AppColors.primary,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
      bodySmall: TextStyle(color: AppColors.darkTextTertiary),
      titleLarge: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: AppColors.darkTextSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style:
          ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryDarkTheme,
            foregroundColor: AppColors.darkTextPrimary,
            elevation: 4,
            shadowColor: AppColors.primaryDarkTheme.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ).copyWith(
            overlayColor: WidgetStateProperty.resolveWith<Color?>((
              Set<WidgetState> states,
            ) {
              if (states.contains(WidgetState.hovered)) {
                return AppColors.darkHoverBackground;
              }
              if (states.contains(WidgetState.pressed)) {
                return AppColors.darkActiveBackground;
              }
              return null;
            }),
          ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCardBackground,
      elevation: 6,
      shadowColor: Colors.black87,
      surfaceTintColor: AppColors.darkAccentGradientStart.withValues(
        alpha: 0.1,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        side: BorderSide(
          color: AppColors.darkBorder.withValues(alpha: 0.3),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    dividerTheme: const DividerThemeData(
      color: AppColors.darkDivider,
      thickness: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.darkBorder.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.darkBorder.withValues(alpha: 0.5),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: AppColors.primaryDarkTheme,
          width: 2.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.errorDark, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.errorDark, width: 2.5),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      hintStyle: TextStyle(
        color: AppColors.darkTextTertiary.withValues(alpha: 0.7),
        fontSize: 16,
      ),
      labelStyle: const TextStyle(
        color: AppColors.darkTextSecondary,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      floatingLabelStyle: TextStyle(
        color: AppColors.primaryDarkTheme.withValues(alpha: 0.9),
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSecondaryBackground,
      selectedItemColor: AppColors.primaryDarkTheme,
      unselectedItemColor: AppColors.darkTextSecondary.withValues(alpha: 0.7),
      elevation: 12,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkModalBackground,
      elevation: 16,
      shadowColor: Colors.black87,
      surfaceTintColor: AppColors.darkAccentGradientStart.withValues(
        alpha: 0.05,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      titleTextStyle: const TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.darkTextSecondary,
        fontSize: 16,
        height: 1.5,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.darkElevatedBackground,
      contentTextStyle: const TextStyle(
        color: AppColors.darkTextPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      actionTextColor: AppColors.primaryDarkTheme,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 8,
    ),
  );

  // This class is not meant to be instantiated.
  AppTheme._();
}
