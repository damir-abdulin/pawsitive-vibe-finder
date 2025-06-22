import 'package:flutter/material.dart';

/// Base class for all app settings events.
sealed class AppSettingsEvent {
  const AppSettingsEvent();
}

/// Event to load the current app settings.
final class LoadAppSettingsEvent extends AppSettingsEvent {
  const LoadAppSettingsEvent();
}

/// Event to change the theme mode.
final class ChangeThemeModeEvent extends AppSettingsEvent {
  /// Creates a [ChangeThemeModeEvent].
  const ChangeThemeModeEvent({required this.themeMode});

  /// The new theme mode to apply.
  final ThemeMode themeMode;
}

/// Event to change the language.
final class ChangeLanguageEvent extends AppSettingsEvent {
  /// Creates a [ChangeLanguageEvent].
  const ChangeLanguageEvent({required this.languageCode});

  /// The new language code to apply.
  final String languageCode;
}
