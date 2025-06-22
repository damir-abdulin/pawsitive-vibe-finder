import 'package:flutter/material.dart';

/// A comprehensive color palette for the Pawsitive Vibe Finder application.
///
/// This class provides a centralized collection of colors used throughout
/// the application, supporting both light and dark theme modes. All colors
/// are carefully chosen to create a cohesive, accessible, and visually
/// appealing user experience.
///
/// The color system follows Material Design 3 principles and includes:
/// - Primary brand colors for both light and dark themes
/// - Background colors with proper contrast ratios
/// - Text colors for optimal readability
/// - Semantic colors for success, error, warning, and info states
/// - Interactive state colors for hover and active states
/// - Gradient colors for enhanced visual appeal
///
/// Usage:
/// ```dart
/// Container(
///   color: AppColors.primary,
///   child: Text(
///     'Hello World',
///     style: TextStyle(color: AppColors.textPrimary),
///   ),
/// )
/// ```
class AppColors {
  // ========== LIGHT THEME COLORS ==========

  /// Primary brand color for light theme.
  ///
  /// A soft pinkish color that represents the warm, friendly nature
  /// of the Pawsitive Vibe Finder brand.
  static const Color primary = Color(0xFFE8B4B7);

  /// Darker variant of the primary color for light theme.
  ///
  /// Used for hover states, pressed states, and subtle variations
  /// of the primary color in light theme contexts.
  static const Color primaryDark = Color(0xFFD8A0A4);

  /// Accent color for light theme.
  ///
  /// Complements the primary color and is used for highlights,
  /// active states, and secondary brand elements.
  static const Color accent = Color(0xFFE8B4B7);

  /// Primary background color for light theme.
  ///
  /// A very light, warm off-white that provides a gentle backdrop
  /// for content without being harsh on the eyes.
  static const Color primaryBackground = Color(0xFFFBF9F9);

  /// Secondary background color for light theme.
  ///
  /// Used for cards, elevated surfaces, and areas that need subtle
  /// differentiation from the primary background.
  static const Color secondaryBackground = Color(0xFFF1E9EA);

  /// Primary text color for light theme.
  ///
  /// A dark, high-contrast color that ensures excellent readability
  /// against light backgrounds.
  static const Color textPrimary = Color(0xFF191011);

  /// Secondary text color for light theme.
  ///
  /// Used for less prominent text elements like captions, helper text,
  /// and secondary information.
  static const Color textSecondary = Color(0xFF8B5B5D);

  // ========== BEAUTIFUL DARK THEME COLORS ==========

  /// Primary brand color for dark theme.
  ///
  /// A vibrant pink that maintains brand consistency while providing
  /// excellent visibility against dark backgrounds.
  static const Color primaryDarkTheme = Color(0xFFFF6B9D);

  /// Softer variant of the primary color for dark theme.
  ///
  /// Used for subtle accents and secondary brand elements in dark mode.
  static const Color primaryDarkShade = Color(0xFFE8B4B7);

  /// Accent color for dark theme.
  ///
  /// Complements the primary dark theme color and is used for
  /// highlights and interactive elements.
  static const Color accentDark = Color(0xFFFF6B9D);

  // Background Colors - Modern Dark Theme
  static const Color darkPrimaryBackground = Color(
    0xFF0D1121,
  ); // Deep navy background
  static const Color darkSecondaryBackground = Color(
    0xFF1A1F36,
  ); // Rich slate background
  static const Color darkSurfaceBackground = Color(
    0xFF252B42,
  ); // Elevated surface
  static const Color darkCardBackground = Color(0xFF1E2340); // Card backgrounds
  static const Color darkModalBackground = Color(
    0xFF161B2E,
  ); // Modal/dialog backgrounds

  // Text Colors - Enhanced Dark Theme
  static const Color darkTextPrimary = Color(0xFFF8FAFC); // Soft white text
  static const Color darkTextSecondary = Color(0xFFCBD5E1); // Light slate text
  static const Color darkTextTertiary = Color(0xFF94A3B8); // Muted slate text
  static const Color darkTextDisabled = Color(0xFF64748B); // Disabled text

  // Border and Divider Colors - Enhanced Dark Theme
  static const Color darkBorder = Color(0xFF334155); // Subtle slate borders
  static const Color darkDivider = Color(0xFF1E293B); // Elegant divider lines
  static const Color darkBorderHover = Color(0xFF475569); // Hover state borders

  // ========== NEUTRAL COLORS ==========

  /// Pure white color.
  ///
  /// Used for high-contrast elements and as a base for
  /// light theme variations.
  static const Color white = Color(0xFFFFFFFF);

  /// Pure black color.
  ///
  /// Used for high-contrast elements and as a base for
  /// dark theme variations.
  static const Color black = Color(0xFF000000);

  /// Light grey color.
  ///
  /// Used for subtle background variations and disabled states
  /// in light theme contexts.
  static const Color lightGrey = Color(
    0xFFF2F2F7,
  ); // For light theme backgrounds
  static const Color midGrey = Color(
    0xFFC7C7CC,
  ); // For dividers or disabled elements
  static const Color darkGrey = Color(0xFF8E8E93); // For secondary text
  static const Color text = Color(0xFF1D1D1F); // For primary text

  // ========== ENHANCED SEMANTIC COLORS ==========

  /// Success color for light theme.
  ///
  /// Used to indicate successful operations, positive feedback,
  /// and completed actions.
  static const Color success = Color(0xFF10B981);

  /// Error color for light theme.
  ///
  /// Used to indicate errors, failures, and critical issues
  /// that require user attention.
  static const Color error = Color(0xFFEF4444);

  /// Warning color for light theme.
  ///
  /// Used to indicate warnings, cautions, and situations
  /// that require user awareness.
  static const Color warning = Color(0xFFF59E0B);

  /// Info color for light theme.
  ///
  /// Used to indicate informational messages, tips,
  /// and general guidance.
  static const Color info = Color(0xFF3B82F6);

  /// Dark error color.
  ///
  /// Used to indicate errors, failures, and critical issues
  /// that require user attention in dark theme contexts.
  static const Color errorDark = Color(0xFFF87171);

  // ========== ENHANCED INTERACTIVE COLORS ==========

  /// Hover background color for light theme.
  ///
  /// Used for interactive elements to indicate hover state
  /// through subtle background color changes.
  static const Color hoverBackground = Color(0xFFF8FAFC);

  /// Active background color for light theme.
  ///
  /// Used for interactive elements to indicate pressed or
  /// active state through background color changes.
  static const Color activeBackground = Color(0xFFF1F5F9);

  /// Divider color for light theme.
  ///
  /// Used for horizontal and vertical dividers to separate
  /// content sections in light theme contexts.
  static const Color dividerColor = Color(0xFFF1F5F9);

  // Dark Theme Interactive States - Modern & Beautiful
  static const Color darkHoverBackground = Color(0xFF2D3748); // Warm hover
  static const Color darkActiveBackground = Color(0xFF4A5568); // Active state
  static const Color darkElevatedBackground = Color(
    0xFF2A2F3A,
  ); // Elevated surfaces
  static const Color darkGlowBackground = Color(
    0xFF1A202C,
  ); // Subtle glow backgrounds
  static const Color darkHighlightBackground = Color(
    0xFF4C51BF,
  ); // Highlight backgrounds

  // Beautiful Gradient Colors for Dark Theme
  static const Color darkGradientStart = Color(
    0xFF667EEA,
  ); // Purple gradient start
  static const Color darkGradientEnd = Color(0xFF764BA2); // Purple gradient end
  static const Color darkAccentGradientStart = Color(
    0xFFFF6B9D,
  ); // Pink gradient start
  static const Color darkAccentGradientEnd = Color(
    0xFFC643E6,
  ); // Purple gradient end

  // This class is not meant to be instantiated.
  AppColors._();
}
