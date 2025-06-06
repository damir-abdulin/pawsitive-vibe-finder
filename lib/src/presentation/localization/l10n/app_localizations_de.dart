// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get helloWorld => 'Hallo Welt!';

  @override
  String get appTitle => 'Pawsitive Vibe Finder';

  @override
  String get homeWelcome => 'Willkommen!';

  @override
  String get homeError => 'Etwas ist schief gelaufen!';

  @override
  String homeBreedLabel(Object breedName) {
    return 'Rasse: $breedName';
  }
}
