import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pawsitive_vibe_finder/src/presentation/localization/l10n/app_localizations.dart';
import 'package:pawsitive_vibe_finder/src/presentation/navigation/app_router.dart';
import 'package:pawsitive_vibe_finder/src/presentation/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(); // Initialize your AppRouter

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pawsitive Vibe Finder',
      theme: AppTheme.lightTheme, // Default light theme
      darkTheme: AppTheme.darkTheme, // Dark theme
      themeMode: ThemeMode.system, // Respect system theme preference
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales:
          AppLocalizations.supportedLocales, // Define supported locales

      routerConfig: appRouter.config(),
    );
  }
}
