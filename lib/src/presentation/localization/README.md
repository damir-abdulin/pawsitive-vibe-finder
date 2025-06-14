# Localization Documentation

This directory contains the internationalization (i18n) and localization (l10n) implementation for the Pawsitive Vibe Finder application.

## Overview

The application supports multiple languages using Flutter's built-in localization system with `.arb` (Application Resource Bundle) files. The localization is properly configured following Clean Architecture principles and Flutter best practices.

## Supported Languages

Currently, the application supports the following languages:

- **English (en)** - Default language
- **French (fr)** - Français
- **Spanish (es)** - Español  
- **German (de)** - Deutsch
- **Italian (it)** - Italiano
- **Portuguese (pt)** - Português

## Directory Structure

```
localization/
├── app_localizations.dart          # Export file for generated localizations
├── locale_extension.dart           # BuildContext extension for easy access
├── l10n/                           # Generated localizations directory
│   ├── app_localizations.dart      # Main generated localizations class
│   ├── app_localizations_en.dart   # English localizations
│   ├── app_localizations_fr.dart   # French localizations  
│   ├── app_localizations_es.dart   # Spanish localizations
│   ├── app_localizations_de.dart   # German localizations
│   ├── app_localizations_it.dart   # Italian localizations
│   ├── app_localizations_pt.dart   # Portuguese localizations
│   ├── app_en.arb                 # English translation source
│   ├── app_fr.arb                 # French translation source
│   ├── app_es.arb                 # Spanish translation source
│   ├── app_de.arb                 # German translation source
│   ├── app_it.arb                 # Italian translation source
│   └── app_pt.arb                 # Portuguese translation source
└── README.md                       # This documentation file
```

## Configuration

The localization is configured through the `l10n.yaml` file in the project root:

```yaml
arb-dir: lib/src/presentation/localization/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart 
```

## Usage

### Accessing Localized Strings

The application provides a convenient extension on `BuildContext` for easy access to localized strings:

```dart
import '../localization/locale_extension.dart';

// In any widget
Text(context.locale.appTitle)
Text(context.locale.homeBreedLabel('Golden Retriever'))
```

### Direct Access

You can also access localizations directly:

```dart
import '../localization/app_localizations.dart';

final localizations = AppLocalizations.of(context)!;
Text(localizations.appTitle)
```

## Translation Categories

The translations are organized into the following categories:

### 1. App-wide Strings
- `appTitle` - Main application title
- `appGlobalTitle` - Global title used throughout the app
- `helloWorld` - Test greeting string
- `somethingWentWrong` - Generic error message

### 2. Navigation & UI Elements
- `drawerTitle`, `drawerHome`, `drawerBreeds`, `drawerFavorites` - Navigation drawer
- `homeScreenTitle`, `breedListScreenTitle`, `favoritesScreenTitle` - Screen titles
- `okButton`, `imageCardLike`, `imageCardOther` - UI buttons and actions

### 3. Home Screen
- `homeWelcome` - Welcome message
- `homeBreedLabel` - Breed label with parameter
- `homeGetStartedButton` - Call-to-action button

### 4. Favorites Screen
- `favoritesTitle` - Screen title
- `favoritesEmptyMessage` - Message when no favorites exist
- `favoritesScreenMessage` - General screen message

### 5. Breed List Screen
- `breedListTitle` - Screen title
- `breedListFailedToLoad` - Error message
- `breedListNoBreedsFound` - Empty state message
- `breedListSearchHint` - Search input placeholder

### 6. Dog Breed Names
Complete translations for 150+ dog breeds, including:
- Common breeds: `beagle`, `labrador`, `germanshepherd`
- Regional breeds: `bakharwalIndian`, `chippiparaiIndian`, `mudholIndian`
- Breed varieties: `bulldogEnglish`, `bulldogFrench`, `bulldogBoston`
- Terrier varieties: `terrierYorkshire`, `terrierScottish`, `terrierWelsh`

### 7. Offline & Error Handling
- `offlineDialogTitle`, `offlineDialogMessage` - Offline state
- `errorMessage` - Generic error with parameter
- `unknownBreed` - Fallback for unknown breeds
- `noImageAvailable` - Image loading fallback

### 8. User Interactions
- `swipeRightToLike`, `swipeLeftToSkip` - Gesture instructions
- `offlineMessage` - Connectivity message

## Adding New Languages

To add support for a new language:

1. **Create ARB file**: Create a new `.arb` file in the `l10n/` directory following the naming convention `app_{locale}.arb` (e.g., `app_ja.arb` for Japanese).

2. **Copy structure**: Copy the structure from `app_en.arb` and translate all values:

```json
{
  "@@locale": "ja",
  "helloWorld": "こんにちは世界！",
  "appTitle": "ポジティブバイブファインダー",
  // ... translate all other keys
}
```

3. **Generate localizations**: Run the code generation command:

```bash
flutter gen-l10n
```

4. **Update app configuration**: Ensure the new locale is supported in your app's `MaterialApp` configuration.

## Adding New Translation Keys

When adding new translatable text:

1. **Add to template**: Add the new key to `app_en.arb` first:

```json
{
  "newKey": "English text",
  "@newKey": {
    "description": "Description of what this text is for"
  }
}
```

2. **Add to all languages**: Add the corresponding translation to all other `.arb` files.

3. **Regenerate**: Run `flutter gen-l10n` to regenerate the localization classes.

4. **Use in code**: Access the new string using `context.locale.newKey`.

## Parameters in Translations

The localization system supports parameterized strings:

```json
{
  "homeBreedLabel": "Breed: {breedName}",
  "@homeBreedLabel": {
    "placeholders": {
      "breedName": {
        "type": "String"
      }
    }
  }
}
```

Usage in code:
```dart
Text(context.locale.homeBreedLabel('Golden Retriever'))
```

## Best Practices

### 1. Consistent Naming
- Use camelCase for key names
- Group related keys with prefixes (e.g., `drawer*`, `breed*`)
- Use descriptive names that indicate context

### 2. Professional Translations
- All breed names have been properly localized to their native language equivalents
- UI text follows language-specific conventions
- Cultural considerations are taken into account

### 3. Maintenance
- Keep all language files synchronized
- Test with different locales during development
- Validate translations with native speakers when possible

### 4. Performance
- Localization files are generated at build time
- No runtime overhead for translation lookup
- Efficient memory usage with Flutter's built-in system

## Technical Implementation

### Architecture Integration
The localization follows Clean Architecture principles:
- **Presentation Layer**: Contains all translation files and UI-related text
- **Domain Layer**: Remains language-agnostic
- **Data Layer**: Handles API responses in their original language

### Code Organization
- `locale_extension.dart`: Provides convenient access pattern
- `app_localizations.dart`: Re-exports generated classes
- Generated files: Handle the actual localization logic

### Type Safety
All translations are type-safe and compile-time checked, preventing runtime errors from missing translations.

## Supported Features

✅ Complete breed name translations (150+ breeds)  
✅ Parameterized strings with type safety  
✅ Offline state handling  
✅ Error message localization  
✅ UI element translations  
✅ Screen navigation translations  
✅ User interaction guidance  
✅ Cultural adaptation for each language  

## Future Enhancements

Consider adding support for:
- Right-to-left (RTL) languages (Arabic, Hebrew)
- Asian languages (Japanese, Chinese, Korean)  
- Nordic languages (Swedish, Norwegian, Finnish)
- Additional European languages (Dutch, Polish, Czech)

## Regenerating Localizations

After making changes to any `.arb` file, regenerate the localization classes:

```bash
flutter gen-l10n
```

This command reads the `l10n.yaml` configuration and generates the appropriate Dart classes for all supported languages. 