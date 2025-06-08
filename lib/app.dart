import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'src/presentation/localization/l10n/app_localizations.dart';
import 'src/presentation/navigation/app_router.dart';
import 'src/presentation/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter(); // Initialize your AppRouter

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pawsitive Vibe Finder',
      theme: AppTheme.lightTheme, // Default light theme
      darkTheme: AppTheme.darkTheme, // Dark theme
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
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
