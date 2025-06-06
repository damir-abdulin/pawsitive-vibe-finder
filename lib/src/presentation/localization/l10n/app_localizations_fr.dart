// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour le monde!';

  @override
  String get appTitle => 'Chercheur d\'Ambiance Pawsitive';

  @override
  String get homeWelcome => 'Bienvenue!';

  @override
  String get homeError => 'Quelque chose s\'est mal passé!';

  @override
  String homeBreedLabel(Object breedName) {
    return 'Race: $breedName';
  }
}
