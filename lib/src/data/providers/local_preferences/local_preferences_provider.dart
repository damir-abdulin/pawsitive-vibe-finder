/// An abstract interface for a provider that manages local user preferences.
abstract class LocalPreferencesProvider {
  /// Gets a boolean value for the given key.
  ///
  /// Defaults to `false` if the key does not exist.
  Future<bool> getBool(String key);

  /// Sets a boolean value for the given key.
  Future<void> setBool(String key, bool value);

  /// Gets a string value for the given key.
  ///
  /// Returns `null` if the key does not exist.
  Future<String?> getString(String key);

  /// Sets a string value for the given key.
  Future<void> setString(String key, String value);
}
