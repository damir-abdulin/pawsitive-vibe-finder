import '../models/models.dart';

/// An abstract interface for managing user preferences.
abstract class PreferencesRepository {
  /// Checks if this is the first time the user is launching the app.
  Future<bool> isFirstLaunch();

  /// Marks that the first-launch sequence has been completed.
  Future<void> setFirstLaunchCompleted();

  /// Caches the last successfully fetched dog.
  Future<void> saveLastDog(RandomDogModel dog);

  /// Retrieves the last cached dog.
  Future<RandomDogModel?> getLastDog();
}
