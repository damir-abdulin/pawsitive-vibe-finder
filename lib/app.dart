import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/di/service_locator.dart';
import 'src/presentation/bloc/app_settings/app_settings_bloc.dart';
import 'src/presentation/bloc/app_settings/app_settings_event.dart';
import 'src/presentation/bloc/app_settings/app_settings_state.dart';
import 'src/presentation/localization/l10n/app_localizations.dart';
import 'src/presentation/navigation/app_router.dart';
import 'src/presentation/theme/app_theme.dart';

/// The main application widget for Pawsitive Vibe Finder.
///
/// This widget is the root of the application and configures all global
/// settings including:
/// - Theme management (light/dark mode support)
/// - Internationalization and localization
/// - Routing configuration using AutoRoute
/// - BLoC pattern setup for global state management
///
/// The app follows Clean Architecture principles and uses Material Design 3.
class App extends StatelessWidget {
  /// Creates the main [App] widget.
  ///
  /// This widget should be used as the root widget passed to [runApp].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppSettingsBloc>(
      create: (BuildContext context) =>
          appLocator<AppSettingsBloc>()..add(const LoadAppSettingsEvent()),
      child: BlocBuilder<AppSettingsBloc, AppSettingsState>(
        builder: (BuildContext context, AppSettingsState state) {
          final AppRouter appRouter = appLocator<AppRouter>();

          ThemeMode themeMode = ThemeMode.system;
          Locale? locale;

          if (state is AppSettingsLoaded) {
            themeMode = state.themeMode;
            locale = Locale(state.languageCode);
          }

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)?.appGlobalTitle ?? '',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            locale: locale,
            // ignore: avoid-dynamic
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: appRouter.config(),
          );
        },
      ),
    );
  }
}
