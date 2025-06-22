import 'dart:convert';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../entities/dog/dog_entity.dart';
import '../mappers/dog_mapper.dart';
import '../providers/providers.dart';

/// The concrete implementation of the [PreferencesRepository].
class PreferencesRepositoryImpl implements PreferencesRepository {
  final LocalPreferencesProvider _localPreferencesProvider;
  static const String _firstLaunchKey = 'is_first_launch';
  static const String _lastDogKey = 'last_dog_cache';
  static const String _themeModeKey = 'theme_mode';
  static const String _languageCodeKey = 'language_code';

  /// Creates an instance of [PreferencesRepositoryImpl].
  PreferencesRepositoryImpl({
    required LocalPreferencesProvider localPreferencesProvider,
  }) : _localPreferencesProvider = localPreferencesProvider;

  @override
  Future<bool> isFirstLaunch() async {
    // By default, if the key doesn't exist, it's the first launch.
    // So we check if the value is `false` (meaning it has been set before).
    // A bit inverted logic, but `getBool` defaults to `false`.
    // Let's rephrase: `isFirstLaunch` is true if the key has *not* been set to true yet.
    final bool hasBeenLaunched = await _localPreferencesProvider.getBool(
      _firstLaunchKey,
    );
    return !hasBeenLaunched;
  }

  @override
  Future<void> setFirstLaunchCompleted() async {
    await _localPreferencesProvider.setBool(_firstLaunchKey, true);
  }

  @override
  Future<void> saveLastDog(DogModel dog) async {
    final DogEntity dogEntity = DogMapper.fromDomain(dog);
    final String dogJson = jsonEncode(dogEntity.toJson());
    await _localPreferencesProvider.setString(_lastDogKey, dogJson);
  }

  @override
  Future<DogModel?> getLastDog() async {
    final String? dogJson = await _localPreferencesProvider.getString(
      _lastDogKey,
    );
    if (dogJson != null) {
      final DogEntity dogEntity = DogEntity.fromJson(
        jsonDecode(dogJson) as Map<String, dynamic>,
      );

      return DogMapper.toDomain(dogEntity);
    }
    return null;
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _localPreferencesProvider.setString(_themeModeKey, themeMode.name);
  }

  @override
  Future<ThemeMode> getThemeMode() async {
    final String? themeModeString = await _localPreferencesProvider.getString(
      _themeModeKey,
    );

    if (themeModeString != null) {
      switch (themeModeString) {
        case 'light':
          return ThemeMode.light;
        case 'dark':
          return ThemeMode.dark;
        case 'system':
          return ThemeMode.system;
      }
    }

    return ThemeMode.system; // Default to system theme
  }

  @override
  Future<void> saveLanguageCode(String languageCode) async {
    await _localPreferencesProvider.setString(_languageCodeKey, languageCode);
  }

  @override
  Future<String?> getLanguageCode() async {
    return _localPreferencesProvider.getString(_languageCodeKey);
  }
}
