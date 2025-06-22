import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization/locale_extension.dart';

import 'bloc/settings_bloc.dart';
import 'bloc/settings_event.dart';
import 'widgets/widgets.dart';

/// Body widget for the settings screen.
class SettingsBody extends StatelessWidget {
  /// Creates a [SettingsBody].
  const SettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          // Header
          SettingsHeader(
            onBack: () =>
                context.read<SettingsBloc>().add(const NavigateBackEvent()),
          ),
          // Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey[50]
                    : Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Theme Section
                    const SettingsSection(
                      title: 'Theme',
                      child: ThemeSettingsWidget(),
                    ),
                    const SizedBox(height: 24),
                    // Language Section
                    const SettingsSection(
                      title: 'Language',
                      child: LanguageSettingsWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
