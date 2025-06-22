/// Base class for all settings states.
sealed class SettingsState {
  const SettingsState();
}

/// Initial state of the settings screen.
final class SettingsInitial extends SettingsState {
  const SettingsInitial();
}
