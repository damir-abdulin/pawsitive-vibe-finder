/// Base class for all settings events.
sealed class SettingsEvent {
  const SettingsEvent();
}

/// Event triggered when the user wants to navigate back.
final class NavigateBackEvent extends SettingsEvent {
  const NavigateBackEvent();
}
