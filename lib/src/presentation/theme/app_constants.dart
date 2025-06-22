/// Application-wide constants used throughout the UI.
class AppConstants {
  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);
  static const Duration welcomeAnimationDuration = Duration(milliseconds: 800);

  // Border radius values
  static const double smallBorderRadius = 12.0;
  static const double mediumBorderRadius = 16.0;
  static const double largeBorderRadius = 24.0;

  // Font sizes
  static const double largeFontSize = 20.0;
  static const double mediumFontSize = 16.0;
  static const double smallFontSize = 14.0;
  static const double extraSmallFontSize = 12.0;
  static const double tinyFontSize = 11.0;

  // Icon sizes
  static const double largeIconSize = 64.0;
  static const double mediumIconSize = 48.0;
  static const double smallIconSize = 28.0;
  static const double extraSmallIconSize = 24.0;

  // Padding and margins
  static const double extraSmallPadding = 4.0;
  static const double smallPadding = 8.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double extraLargePadding = 32.0;
  static const double hugePadding = 48.0;

  // Card and container dimensions
  static const double cardHeight = 500.0;
  static const double dragBorderThreshold = 300.0;
  static const double cardBottomPadding = 100.0;

  // Quiz constants
  static const int totalQuizQuestions = 10;

  // Letter spacing
  static const double defaultLetterSpacing = -0.25;
  static const double mediumLetterSpacing = -0.5;
  static const double positiveLetterSpacing = 0.5;

  // Elevation values
  static const double lowElevation = 4.0;
  static const double mediumElevation = 6.0;
  static const double highElevation = 8.0;
  static const double extraHighElevation = 12.0;
  static const double maximumElevation = 16.0;

  // Alpha values for transparency
  static const double lowOpacity = 0.05;
  static const double mediumOpacity = 0.1;
  static const double highOpacity = 0.3;
  static const double semiTransparent = 0.5;
  static const double mostlyOpaque = 0.7;
  static const double almostOpaque = 0.9;

  // Line height values
  static const double defaultLineHeight = 1.5;

  // Border width values
  static const double thinBorder = 1.0;
  static const double mediumBorder = 1.5;
  static const double thickBorder = 2.0;
  static const double extraThickBorder = 2.5;

  // Private constructor to prevent instantiation
  AppConstants._();
}
