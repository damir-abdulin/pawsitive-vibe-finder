import 'package:pawsitive_vibe_finder/src/data/providers/local_preferences/local_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The concrete implementation of [LocalPreferencesProvider] using SharedPreferences.
class LocalPreferencesProviderImpl implements LocalPreferencesProvider {
  final SharedPreferences _sharedPreferences;

  /// Creates an instance of [LocalPreferencesProviderImpl].
  LocalPreferencesProviderImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  @override
  Future<bool> getBool(String key) async {
    return _sharedPreferences.getBool(key) ?? false;
  }

  @override
  Future<void> setBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }
}
