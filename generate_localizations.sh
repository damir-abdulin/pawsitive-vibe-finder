#!/bin/bash
flutter gen-l10n --arb-dir ./lib/src/presentation/localization/l10n --template-arb-file app_en.arb --output-localization-file app_localizations.dart --output-class AppLocalizations
flutter gen-l10n --arb-dir ./lib/src/presentation/localization/l10n/breeds --template-arb-file breeds_en.arb --output-localization-file breed_localizations.dart --output-class BreedLocalizations 