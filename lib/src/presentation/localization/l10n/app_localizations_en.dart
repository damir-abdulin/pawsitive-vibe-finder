// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get appTitle => 'Pawsitive Vibe Finder';

  @override
  String get homeWelcome => 'Welcome!';

  @override
  String get homeError => 'Something went wrong!';

  @override
  String homeBreedLabel(Object breedName) {
    return 'Breed: $breedName';
  }
}
