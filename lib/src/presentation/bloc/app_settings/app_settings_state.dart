import 'package:flutter/material.dart';

/// Base class for all app settings states.
sealed class AppSettingsState {
  const AppSettingsState();
}

/// Initial state of app settings.
final class AppSettingsInitial extends AppSettingsState {
  const AppSettingsInitial();
}

/// State when app settings are loaded.
final class AppSettingsLoaded extends AppSettingsState {
  /// Creates an [AppSettingsLoaded].
  const AppSettingsLoaded({
    required this.themeMode,
    required this.languageCode,
  });

  /// The current theme mode.
  final ThemeMode themeMode;

  /// The current language code.
  final String languageCode;

  /// Creates a copy of this state with optionally updated values.
  AppSettingsLoaded copyWith({ThemeMode? themeMode, String? languageCode}) {
    return AppSettingsLoaded(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }
}
