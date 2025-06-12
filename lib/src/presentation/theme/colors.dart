import 'package:flutter/material.dart';

/// A class that holds the color palette for the application.
class AppColors {
  // This class is not meant to be instantiated.
  AppColors._();

  // Primary Colors - Updated to match new design
  static const Color primary = Color(
    0xFFE8B4B7,
  ); // Light pinkish primary color from design
  static const Color primaryDark = Color(0xFFD8A0A4); // Darker shade

  // Accent Colors - Updated to match new design
  static const Color accent = Color(0xFFE8B4B7); // Accent color from design

  // Background Colors - Updated for new design
  static const Color primaryBackground = Color(0xFFFBF9F9); // Light background
  static const Color secondaryBackground = Color(
    0xFFF1E9EA,
  ); // Light secondary background

  // Text Colors - Updated for new design
  static const Color textPrimary = Color(0xFF191011); // Primary text color
  static const Color textSecondary = Color(0xFF8B5B5D); // Secondary text color

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFF2F2F7); // For backgrounds
  static const Color midGrey = Color(
    0xFFC7C7CC,
  ); // For dividers or disabled elements
  static const Color darkGrey = Color(0xFF8E8E93); // For secondary text
  static const Color text = Color(0xFF1D1D1F); // For primary text

  // Semantic Colors
  static const Color success = Color(0xFF34C759); // For success states
  static const Color error = Color(0xFFFF3B30); // For error states
  static const Color warning = Color(0xFFFF9500); // For warning states

  // Additional colors for hover/active states
  static const Color hoverBackground = Color(0xFFF8FAFC); // slate-50
  static const Color activeBackground = Color(0xFFF1F5F9); // slate-100
  static const Color dividerColor = Color(0xFFF1F5F9); // slate-100
}
