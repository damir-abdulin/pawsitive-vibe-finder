import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/app_settings/app_settings_bloc.dart';
import '../../../bloc/app_settings/app_settings_event.dart';
import '../../../bloc/app_settings/app_settings_state.dart';

/// Widget for theme selection settings.
class ThemeSettingsWidget extends StatelessWidget {
  /// Creates a [ThemeSettingsWidget].
  const ThemeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (BuildContext context, AppSettingsState state) {
        ThemeMode selectedTheme = ThemeMode.system;

        if (state is AppSettingsLoaded) {
          selectedTheme = state.themeMode;
        }

        return Column(
          children: <Widget>[
            _buildThemeOption(
              context: context,
              title: 'Light Theme',
              subtitle: 'Use light theme',
              value: ThemeMode.light,
              icon: Icons.light_mode,
              isSelected: selectedTheme == ThemeMode.light,
            ),
            if (Theme.of(context).brightness == Brightness.dark)
              Divider(height: 1, color: Theme.of(context).dividerTheme.color),
            _buildThemeOption(
              context: context,
              title: 'Dark Theme',
              subtitle: 'Use dark theme',
              value: ThemeMode.dark,
              icon: Icons.dark_mode,
              isSelected: selectedTheme == ThemeMode.dark,
            ),
            if (Theme.of(context).brightness == Brightness.dark)
              Divider(height: 1, color: Theme.of(context).dividerTheme.color),
            _buildThemeOption(
              context: context,
              title: 'System Default',
              subtitle: 'Follow system theme',
              value: ThemeMode.system,
              icon: Icons.brightness_auto,
              isSelected: selectedTheme == ThemeMode.system,
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required ThemeMode value,
    required IconData icon,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onThemeChanged(context, value),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              // Theme icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.15)
                      : Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              // Selection indicator
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onThemeChanged(BuildContext context, ThemeMode theme) {
    context.read<AppSettingsBloc>().add(ChangeThemeModeEvent(themeMode: theme));
  }
}
