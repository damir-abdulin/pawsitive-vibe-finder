import 'package:flutter/material.dart';

/// A class that holds the color palette for the application.
class AppColors {
  // ========== LIGHT THEME COLORS ==========

  // Primary Colors - Light Theme
  static const Color primary = Color(0xFFE8B4B7); // Light pinkish primary color
  static const Color primaryDark = Color(
    0xFFD8A0A4,
  ); // Darker shade for light theme
  static const Color accent = Color(0xFFE8B4B7); // Accent color

  // Background Colors - Light Theme
  static const Color primaryBackground = Color(0xFFFBF9F9); // Light background
  static const Color secondaryBackground = Color(
    0xFFF1E9EA,
  ); // Light secondary background

  // Text Colors - Light Theme
  static const Color textPrimary = Color(0xFF191011); // Primary text color
  static const Color textSecondary = Color(0xFF8B5B5D); // Secondary text color

  // ========== BEAUTIFUL DARK THEME COLORS ==========

  // Primary Colors - Enhanced Dark Theme
  static const Color primaryDarkTheme = Color(
    0xFFFF6B9D,
  ); // Vibrant pink primary for dark
  static const Color primaryDarkShade = Color(0xFFE8B4B7); // Softer pink shade
  static const Color accentDark = Color(
    0xFFFF6B9D,
  ); // Accent color for dark theme

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

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(
    0xFFF2F2F7,
  ); // For light theme backgrounds
  static const Color midGrey = Color(
    0xFFC7C7CC,
  ); // For dividers or disabled elements
  static const Color darkGrey = Color(0xFF8E8E93); // For secondary text
  static const Color text = Color(0xFF1D1D1F); // For primary text

  // ========== ENHANCED SEMANTIC COLORS ==========

  // Light Theme Semantic Colors
  static const Color success = Color(0xFF10B981); // Emerald success
  static const Color error = Color(0xFFEF4444); // Red error
  static const Color warning = Color(0xFFF59E0B); // Amber warning
  static const Color info = Color(0xFF3B82F6); // Blue info

  // Dark Theme Semantic Colors
  static const Color successDark = Color(0xFF34D399); // Bright emerald for dark
  static const Color errorDark = Color(0xFFF87171); // Bright red for dark
  static const Color warningDark = Color(0xFFFBBF24); // Bright amber for dark
  static const Color infoDark = Color(0xFF60A5FA); // Bright blue for dark

  // ========== ENHANCED INTERACTIVE COLORS ==========

  // Light Theme Interactive States
  static const Color hoverBackground = Color(0xFFF8FAFC); // slate-50
  static const Color activeBackground = Color(0xFFF1F5F9); // slate-100
  static const Color dividerColor = Color(0xFFF1F5F9); // slate-100

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
