import 'package:flutter/material.dart';
import '../models/models.dart';

/// An abstract interface for managing user preferences.
abstract class PreferencesRepository {
  /// Checks if this is the first time the user is launching the app.
  Future<bool> isFirstLaunch();

  /// Marks that the first-launch sequence has been completed.
  Future<void> setFirstLaunchCompleted();

  /// Caches the last successfully fetched dog.
  Future<void> saveLastDog(DogModel dog);

  /// Retrieves the last cached dog.
  Future<DogModel?> getLastDog();

  /// Saves the selected theme mode.
  Future<void> saveThemeMode(ThemeMode themeMode);

  /// Retrieves the saved theme mode.
  Future<ThemeMode> getThemeMode();

  /// Saves the selected language code.
  Future<void> saveLanguageCode(String languageCode);

  /// Retrieves the saved language code.
  Future<String?> getLanguageCode();
}
