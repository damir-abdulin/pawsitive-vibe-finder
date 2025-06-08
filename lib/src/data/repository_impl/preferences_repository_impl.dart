import 'dart:convert';

import '../../domain/domain.dart';
import '../providers/providers.dart';

/// The concrete implementation of the [PreferencesRepository].
class PreferencesRepositoryImpl implements PreferencesRepository {
  final LocalPreferencesProvider _localPreferencesProvider;
  static const String _firstLaunchKey = 'is_first_launch';
  static const String _lastDogKey = 'last_dog_cache';

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
  Future<void> saveLastDog(RandomDogModel dog) async {
    final String dogJson = jsonEncode(dog.toJson());
    await _localPreferencesProvider.setString(_lastDogKey, dogJson);
  }

  @override
  Future<RandomDogModel?> getLastDog() async {
    final String? dogJson = await _localPreferencesProvider.getString(_lastDogKey);
    if (dogJson != null) {
      return RandomDogModel.fromJson(
        jsonDecode(dogJson) as Map<String, dynamic>,
      );
    }
    return null;
  }
}
