// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get helloWorld => '¡Hola Mundo!';

  @override
  String get appTitle => 'Buscador de Vibras Pawsitivas';

  @override
  String get homeWelcome => '¡Bienvenido!';

  @override
  String get homeError => '¡Algo salió mal!';

  @override
  String homeBreedLabel(Object breedName) {
    return 'Raza: $breedName';
  }
}
