import 'package:flutter/material.dart';

/// A class that holds the color palette for the application.
class AppColors {
  // This class is not meant to be instantiated.
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF4A90E2); // A friendly, calming blue
  static const Color primaryDark = Color(
    0xFF357ABD,
  ); // A darker shade for accents or dark mode

  // Accent Colors
  static const Color accent = Color(
    0xFFF5A623,
  ); // A warm, sunny orange/yellow for highlights

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
}
