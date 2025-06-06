import 'package:flutter/widgets.dart';
import 'package:pawsitive_vibe_finder/src/presentation/localization/l10n/app_localizations.dart';

/// An extension on [BuildContext] to provide easy access to localized strings.
extension LocaleExtension on BuildContext {
  /// Returns the [AppLocalizations] instance for the current context.
  AppLocalizations get locale => AppLocalizations.of(this)!;
}
