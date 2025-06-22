import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/app_settings/app_settings_bloc.dart';
import '../../../bloc/app_settings/app_settings_event.dart';
import '../../../bloc/app_settings/app_settings_state.dart';

/// Widget for language selection settings.
class LanguageSettingsWidget extends StatelessWidget {
  /// Creates a [LanguageSettingsWidget].
  const LanguageSettingsWidget({super.key});

  // Supported languages based on the l10n files
  static const List<LanguageOption> _languages = <LanguageOption>[
    LanguageOption('en', 'English', '🇺🇸'),
    LanguageOption('es', 'Español', '🇪🇸'),
    LanguageOption('fr', 'Français', '🇫🇷'),
    LanguageOption('de', 'Deutsch', '🇩🇪'),
    LanguageOption('it', 'Italiano', '🇮🇹'),
    LanguageOption('pt', 'Português', '🇵🇹'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      builder: (BuildContext context, AppSettingsState state) {
        String selectedLanguage = 'en';

        if (state is AppSettingsLoaded) {
          selectedLanguage = state.languageCode;
        }

        return Column(
          children: _languages
              .map(
                (LanguageOption language) => Column(
                  children: <Widget>[
                    _buildLanguageOption(
                      context: context,
                      language: language,
                      isSelected: selectedLanguage == language.code,
                    ),
                    if (language != _languages.last &&
                        Theme.of(context).brightness == Brightness.dark)
                      Divider(
                        height: 1,
                        color: Theme.of(context).dividerTheme.color,
                      ),
                  ],
                ),
              )
              .toList(),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required LanguageOption language,
    required bool isSelected,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onLanguageChanged(context, language.code),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              // Language flag
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
                child: Center(
                  child: Text(
                    language.flag,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Language name
              Expanded(
                child: Text(
                  language.name,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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

  void _onLanguageChanged(BuildContext context, String languageCode) {
    context.read<AppSettingsBloc>().add(
      ChangeLanguageEvent(languageCode: languageCode),
    );
  }
}

/// Represents a language option with code, name, and flag.
class LanguageOption {
  /// Creates a [LanguageOption].
  const LanguageOption(this.code, this.name, this.flag);

  /// The language code (e.g., 'en', 'es').
  final String code;

  /// The display name of the language.
  final String name;

  /// The flag emoji for the language.
  final String flag;
}
