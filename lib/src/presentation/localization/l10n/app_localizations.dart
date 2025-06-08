import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World!'**
  String get helloWorld;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Pawsitive Vibe Finder'**
  String get appTitle;

  /// No description provided for @homeWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get homeWelcome;

  /// No description provided for @homeError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get homeError;

  /// No description provided for @homeBreedLabel.
  ///
  /// In en, this message translates to:
  /// **'Breed: {breedName}'**
  String homeBreedLabel(String breedName);

  /// No description provided for @homeGetStartedButton.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get homeGetStartedButton;

  /// No description provided for @offlineDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offlineDialogTitle;

  /// No description provided for @offlineDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'Please connect to the internet to discover more dogs!'**
  String get offlineDialogMessage;

  /// No description provided for @okButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'Favorite Dogs'**
  String get favoritesTitle;

  /// No description provided for @favoritesScreenMessage.
  ///
  /// In en, this message translates to:
  /// **'Favorites Screen'**
  String get favoritesScreenMessage;

  /// No description provided for @drawerTitle.
  ///
  /// In en, this message translates to:
  /// **'Pawsitive Vibe Finder'**
  String get drawerTitle;

  /// No description provided for @drawerHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get drawerHome;

  /// No description provided for @drawerBreeds.
  ///
  /// In en, this message translates to:
  /// **'Breeds'**
  String get drawerBreeds;

  /// No description provided for @drawerFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get drawerFavorites;

  /// No description provided for @imageCardLike.
  ///
  /// In en, this message translates to:
  /// **'LIKE'**
  String get imageCardLike;

  /// No description provided for @imageCardOther.
  ///
  /// In en, this message translates to:
  /// **'OTHER'**
  String get imageCardOther;

  /// No description provided for @breedListTitle.
  ///
  /// In en, this message translates to:
  /// **'Dog Breeds'**
  String get breedListTitle;

  /// No description provided for @breedListFailedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load breeds'**
  String get breedListFailedToLoad;

  /// No description provided for @breedListNoBreedsFound.
  ///
  /// In en, this message translates to:
  /// **'No breeds found'**
  String get breedListNoBreedsFound;

  /// No description provided for @breedListSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search breeds...'**
  String get breedListSearchHint;

  /// No description provided for @appGlobalTitle.
  ///
  /// In en, this message translates to:
  /// **'Pawsitive Vibe Finder'**
  String get appGlobalTitle;

  /// No description provided for @affenpinscher.
  ///
  /// In en, this message translates to:
  /// **'Affenpinscher'**
  String get affenpinscher;

  /// No description provided for @african.
  ///
  /// In en, this message translates to:
  /// **'African'**
  String get african;

  /// No description provided for @airedale.
  ///
  /// In en, this message translates to:
  /// **'Airedale'**
  String get airedale;

  /// No description provided for @akita.
  ///
  /// In en, this message translates to:
  /// **'Akita'**
  String get akita;

  /// No description provided for @appenzeller.
  ///
  /// In en, this message translates to:
  /// **'Appenzeller'**
  String get appenzeller;

  /// No description provided for @australianKelpie.
  ///
  /// In en, this message translates to:
  /// **'Australian Kelpie'**
  String get australianKelpie;

  /// No description provided for @australianShepherd.
  ///
  /// In en, this message translates to:
  /// **'Australian Shepherd'**
  String get australianShepherd;

  /// No description provided for @bakharwalIndian.
  ///
  /// In en, this message translates to:
  /// **'Bakharwal Indian'**
  String get bakharwalIndian;

  /// No description provided for @basenji.
  ///
  /// In en, this message translates to:
  /// **'Basenji'**
  String get basenji;

  /// No description provided for @beagle.
  ///
  /// In en, this message translates to:
  /// **'Beagle'**
  String get beagle;

  /// No description provided for @bluetick.
  ///
  /// In en, this message translates to:
  /// **'Bluetick'**
  String get bluetick;

  /// No description provided for @borzoi.
  ///
  /// In en, this message translates to:
  /// **'Borzoi'**
  String get borzoi;

  /// No description provided for @bouvier.
  ///
  /// In en, this message translates to:
  /// **'Bouvier'**
  String get bouvier;

  /// No description provided for @boxer.
  ///
  /// In en, this message translates to:
  /// **'Boxer'**
  String get boxer;

  /// No description provided for @brabancon.
  ///
  /// In en, this message translates to:
  /// **'Brabancon'**
  String get brabancon;

  /// No description provided for @briard.
  ///
  /// In en, this message translates to:
  /// **'Briard'**
  String get briard;

  /// No description provided for @buhundNorwegian.
  ///
  /// In en, this message translates to:
  /// **'Norwegian Buhund'**
  String get buhundNorwegian;

  /// No description provided for @bulldogBoston.
  ///
  /// In en, this message translates to:
  /// **'Boston Bulldog'**
  String get bulldogBoston;

  /// No description provided for @bulldogEnglish.
  ///
  /// In en, this message translates to:
  /// **'English Bulldog'**
  String get bulldogEnglish;

  /// No description provided for @bulldogFrench.
  ///
  /// In en, this message translates to:
  /// **'French Bulldog'**
  String get bulldogFrench;

  /// No description provided for @bullterrierStaffordshire.
  ///
  /// In en, this message translates to:
  /// **'Staffordshire Bullterrier'**
  String get bullterrierStaffordshire;

  /// No description provided for @cattledogAustralian.
  ///
  /// In en, this message translates to:
  /// **'Australian Cattledog'**
  String get cattledogAustralian;

  /// No description provided for @cavapoo.
  ///
  /// In en, this message translates to:
  /// **'Cavapoo'**
  String get cavapoo;

  /// No description provided for @chihuahua.
  ///
  /// In en, this message translates to:
  /// **'Chihuahua'**
  String get chihuahua;

  /// No description provided for @chippiparaiIndian.
  ///
  /// In en, this message translates to:
  /// **'Chippiparai Indian'**
  String get chippiparaiIndian;

  /// No description provided for @chow.
  ///
  /// In en, this message translates to:
  /// **'Chow'**
  String get chow;

  /// No description provided for @clumber.
  ///
  /// In en, this message translates to:
  /// **'Clumber'**
  String get clumber;

  /// No description provided for @cockapoo.
  ///
  /// In en, this message translates to:
  /// **'Cockapoo'**
  String get cockapoo;

  /// No description provided for @collieBorder.
  ///
  /// In en, this message translates to:
  /// **'Border Collie'**
  String get collieBorder;

  /// No description provided for @coonhound.
  ///
  /// In en, this message translates to:
  /// **'Coonhound'**
  String get coonhound;

  /// No description provided for @corgiCardigan.
  ///
  /// In en, this message translates to:
  /// **'Cardigan Corgi'**
  String get corgiCardigan;

  /// No description provided for @cotondetulear.
  ///
  /// In en, this message translates to:
  /// **'Coton de Tulear'**
  String get cotondetulear;

  /// No description provided for @dachshund.
  ///
  /// In en, this message translates to:
  /// **'Dachshund'**
  String get dachshund;

  /// No description provided for @dalmatian.
  ///
  /// In en, this message translates to:
  /// **'Dalmatian'**
  String get dalmatian;

  /// No description provided for @daneGreat.
  ///
  /// In en, this message translates to:
  /// **'Great Dane'**
  String get daneGreat;

  /// No description provided for @danishSwedish.
  ///
  /// In en, this message translates to:
  /// **'Swedish Danish'**
  String get danishSwedish;

  /// No description provided for @deerhoundScottish.
  ///
  /// In en, this message translates to:
  /// **'Scottish Deerhound'**
  String get deerhoundScottish;

  /// No description provided for @dhole.
  ///
  /// In en, this message translates to:
  /// **'Dhole'**
  String get dhole;

  /// No description provided for @dingo.
  ///
  /// In en, this message translates to:
  /// **'Dingo'**
  String get dingo;

  /// No description provided for @doberman.
  ///
  /// In en, this message translates to:
  /// **'Doberman'**
  String get doberman;

  /// No description provided for @elkhoundNorwegian.
  ///
  /// In en, this message translates to:
  /// **'Norwegian Elkhound'**
  String get elkhoundNorwegian;

  /// No description provided for @entlebucher.
  ///
  /// In en, this message translates to:
  /// **'Entlebucher'**
  String get entlebucher;

  /// No description provided for @eskimo.
  ///
  /// In en, this message translates to:
  /// **'Eskimo'**
  String get eskimo;

  /// No description provided for @finnishLapphund.
  ///
  /// In en, this message translates to:
  /// **'Finnish Lapphund'**
  String get finnishLapphund;

  /// No description provided for @friseBichon.
  ///
  /// In en, this message translates to:
  /// **'Bichon Frise'**
  String get friseBichon;

  /// No description provided for @gaddiIndian.
  ///
  /// In en, this message translates to:
  /// **'Gaddi Indian'**
  String get gaddiIndian;

  /// No description provided for @germanshepherd.
  ///
  /// In en, this message translates to:
  /// **'German Shepherd'**
  String get germanshepherd;

  /// No description provided for @greyhoundIndian.
  ///
  /// In en, this message translates to:
  /// **'Indian Greyhound'**
  String get greyhoundIndian;

  /// No description provided for @greyhoundItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian Greyhound'**
  String get greyhoundItalian;

  /// No description provided for @groenendael.
  ///
  /// In en, this message translates to:
  /// **'Groenendael'**
  String get groenendael;

  /// No description provided for @havanese.
  ///
  /// In en, this message translates to:
  /// **'Havanese'**
  String get havanese;

  /// No description provided for @houndAfghan.
  ///
  /// In en, this message translates to:
  /// **'Afghan Hound'**
  String get houndAfghan;

  /// No description provided for @houndBasset.
  ///
  /// In en, this message translates to:
  /// **'Basset Hound'**
  String get houndBasset;

  /// No description provided for @houndBlood.
  ///
  /// In en, this message translates to:
  /// **'Blood Hound'**
  String get houndBlood;

  /// No description provided for @houndEnglish.
  ///
  /// In en, this message translates to:
  /// **'English Hound'**
  String get houndEnglish;

  /// No description provided for @houndIbizan.
  ///
  /// In en, this message translates to:
  /// **'Ibizan Hound'**
  String get houndIbizan;

  /// No description provided for @houndPlott.
  ///
  /// In en, this message translates to:
  /// **'Plott Hound'**
  String get houndPlott;

  /// No description provided for @houndWalker.
  ///
  /// In en, this message translates to:
  /// **'Walker Hound'**
  String get houndWalker;

  /// No description provided for @husky.
  ///
  /// In en, this message translates to:
  /// **'Husky'**
  String get husky;

  /// No description provided for @keeshond.
  ///
  /// In en, this message translates to:
  /// **'Keeshond'**
  String get keeshond;

  /// No description provided for @kelpie.
  ///
  /// In en, this message translates to:
  /// **'Kelpie'**
  String get kelpie;

  /// No description provided for @kombai.
  ///
  /// In en, this message translates to:
  /// **'Kombai'**
  String get kombai;

  /// No description provided for @komondor.
  ///
  /// In en, this message translates to:
  /// **'Komondor'**
  String get komondor;

  /// No description provided for @kuvasz.
  ///
  /// In en, this message translates to:
  /// **'Kuvasz'**
  String get kuvasz;

  /// No description provided for @labradoodle.
  ///
  /// In en, this message translates to:
  /// **'Labradoodle'**
  String get labradoodle;

  /// No description provided for @labrador.
  ///
  /// In en, this message translates to:
  /// **'Labrador'**
  String get labrador;

  /// No description provided for @leonberg.
  ///
  /// In en, this message translates to:
  /// **'Leonberg'**
  String get leonberg;

  /// No description provided for @lhasa.
  ///
  /// In en, this message translates to:
  /// **'Lhasa'**
  String get lhasa;

  /// No description provided for @malamute.
  ///
  /// In en, this message translates to:
  /// **'Malamute'**
  String get malamute;

  /// No description provided for @malinois.
  ///
  /// In en, this message translates to:
  /// **'Malinois'**
  String get malinois;

  /// No description provided for @maltese.
  ///
  /// In en, this message translates to:
  /// **'Maltese'**
  String get maltese;

  /// No description provided for @mastiffBull.
  ///
  /// In en, this message translates to:
  /// **'Bull Mastiff'**
  String get mastiffBull;

  /// No description provided for @mastiffEnglish.
  ///
  /// In en, this message translates to:
  /// **'English Mastiff'**
  String get mastiffEnglish;

  /// No description provided for @mastiffIndian.
  ///
  /// In en, this message translates to:
  /// **'Indian Mastiff'**
  String get mastiffIndian;

  /// No description provided for @mastiffTibetan.
  ///
  /// In en, this message translates to:
  /// **'Tibetan Mastiff'**
  String get mastiffTibetan;

  /// No description provided for @mexicanhairless.
  ///
  /// In en, this message translates to:
  /// **'Mexican Hairless'**
  String get mexicanhairless;

  /// No description provided for @mix.
  ///
  /// In en, this message translates to:
  /// **'Mix'**
  String get mix;

  /// No description provided for @mountainBernese.
  ///
  /// In en, this message translates to:
  /// **'Bernese Mountain'**
  String get mountainBernese;

  /// No description provided for @mountainSwiss.
  ///
  /// In en, this message translates to:
  /// **'Swiss Mountain'**
  String get mountainSwiss;

  /// No description provided for @mudholIndian.
  ///
  /// In en, this message translates to:
  /// **'Mudhol Indian'**
  String get mudholIndian;

  /// No description provided for @newfoundland.
  ///
  /// In en, this message translates to:
  /// **'Newfoundland'**
  String get newfoundland;

  /// No description provided for @otterhound.
  ///
  /// In en, this message translates to:
  /// **'Otterhound'**
  String get otterhound;

  /// No description provided for @ovcharkaCaucasian.
  ///
  /// In en, this message translates to:
  /// **'Caucasian Ovcharka'**
  String get ovcharkaCaucasian;

  /// No description provided for @papillon.
  ///
  /// In en, this message translates to:
  /// **'Papillon'**
  String get papillon;

  /// No description provided for @pariahIndian.
  ///
  /// In en, this message translates to:
  /// **'Indian Pariah'**
  String get pariahIndian;

  /// No description provided for @pekinese.
  ///
  /// In en, this message translates to:
  /// **'Pekinese'**
  String get pekinese;

  /// No description provided for @pembroke.
  ///
  /// In en, this message translates to:
  /// **'Pembroke'**
  String get pembroke;

  /// No description provided for @pinscherMiniature.
  ///
  /// In en, this message translates to:
  /// **'Miniature Pinscher'**
  String get pinscherMiniature;

  /// No description provided for @pitbull.
  ///
  /// In en, this message translates to:
  /// **'Pitbull'**
  String get pitbull;

  /// No description provided for @pointerGerman.
  ///
  /// In en, this message translates to:
  /// **'German Pointer'**
  String get pointerGerman;

  /// No description provided for @pointerGermanlonghair.
  ///
  /// In en, this message translates to:
  /// **'German Longhaired Pointer'**
  String get pointerGermanlonghair;

  /// No description provided for @pomeranian.
  ///
  /// In en, this message translates to:
  /// **'Pomeranian'**
  String get pomeranian;

  /// No description provided for @poodleMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium Poodle'**
  String get poodleMedium;

  /// No description provided for @poodleMiniature.
  ///
  /// In en, this message translates to:
  /// **'Miniature Poodle'**
  String get poodleMiniature;

  /// No description provided for @poodleStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard Poodle'**
  String get poodleStandard;

  /// No description provided for @poodleToy.
  ///
  /// In en, this message translates to:
  /// **'Toy Poodle'**
  String get poodleToy;

  /// No description provided for @pug.
  ///
  /// In en, this message translates to:
  /// **'Pug'**
  String get pug;

  /// No description provided for @puggle.
  ///
  /// In en, this message translates to:
  /// **'Puggle'**
  String get puggle;

  /// No description provided for @pyrenees.
  ///
  /// In en, this message translates to:
  /// **'Pyrenees'**
  String get pyrenees;

  /// No description provided for @rajapalayamIndian.
  ///
  /// In en, this message translates to:
  /// **'Rajapalayam Indian'**
  String get rajapalayamIndian;

  /// No description provided for @redbone.
  ///
  /// In en, this message translates to:
  /// **'Redbone'**
  String get redbone;

  /// No description provided for @retrieverChesapeake.
  ///
  /// In en, this message translates to:
  /// **'Chesapeake Retriever'**
  String get retrieverChesapeake;

  /// No description provided for @retrieverCurly.
  ///
  /// In en, this message translates to:
  /// **'Curly Retriever'**
  String get retrieverCurly;

  /// No description provided for @retrieverFlatcoated.
  ///
  /// In en, this message translates to:
  /// **'Flatcoated Retriever'**
  String get retrieverFlatcoated;

  /// No description provided for @retrieverGolden.
  ///
  /// In en, this message translates to:
  /// **'Golden Retriever'**
  String get retrieverGolden;

  /// No description provided for @ridgebackRhodesian.
  ///
  /// In en, this message translates to:
  /// **'Rhodesian Ridgeback'**
  String get ridgebackRhodesian;

  /// No description provided for @rottweiler.
  ///
  /// In en, this message translates to:
  /// **'Rottweiler'**
  String get rottweiler;

  /// No description provided for @saluki.
  ///
  /// In en, this message translates to:
  /// **'Saluki'**
  String get saluki;

  /// No description provided for @samoyed.
  ///
  /// In en, this message translates to:
  /// **'Samoyed'**
  String get samoyed;

  /// No description provided for @schipperke.
  ///
  /// In en, this message translates to:
  /// **'Schipperke'**
  String get schipperke;

  /// No description provided for @schnauzerGiant.
  ///
  /// In en, this message translates to:
  /// **'Giant Schnauzer'**
  String get schnauzerGiant;

  /// No description provided for @schnauzerMiniature.
  ///
  /// In en, this message translates to:
  /// **'Miniature Schnauzer'**
  String get schnauzerMiniature;

  /// No description provided for @segugioItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian Segugio'**
  String get segugioItalian;

  /// No description provided for @setterEnglish.
  ///
  /// In en, this message translates to:
  /// **'English Setter'**
  String get setterEnglish;

  /// No description provided for @setterGordon.
  ///
  /// In en, this message translates to:
  /// **'Gordon Setter'**
  String get setterGordon;

  /// No description provided for @setterIrish.
  ///
  /// In en, this message translates to:
  /// **'Irish Setter'**
  String get setterIrish;

  /// No description provided for @sharpei.
  ///
  /// In en, this message translates to:
  /// **'Shar-Pei'**
  String get sharpei;

  /// No description provided for @sheepdogEnglish.
  ///
  /// In en, this message translates to:
  /// **'English Sheepdog'**
  String get sheepdogEnglish;

  /// No description provided for @sheepdogIndian.
  ///
  /// In en, this message translates to:
  /// **'Indian Sheepdog'**
  String get sheepdogIndian;

  /// No description provided for @sheepdogShetland.
  ///
  /// In en, this message translates to:
  /// **'Shetland Sheepdog'**
  String get sheepdogShetland;

  /// No description provided for @shiba.
  ///
  /// In en, this message translates to:
  /// **'Shiba'**
  String get shiba;

  /// No description provided for @shihtzu.
  ///
  /// In en, this message translates to:
  /// **'Shih Tzu'**
  String get shihtzu;

  /// No description provided for @spanielBlenheim.
  ///
  /// In en, this message translates to:
  /// **'Cavalier King Charles Spaniel'**
  String get spanielBlenheim;

  /// No description provided for @spanielBrittany.
  ///
  /// In en, this message translates to:
  /// **'Brittany Spaniel'**
  String get spanielBrittany;

  /// No description provided for @spanielCocker.
  ///
  /// In en, this message translates to:
  /// **'Cocker Spaniel'**
  String get spanielCocker;

  /// No description provided for @spanielIrish.
  ///
  /// In en, this message translates to:
  /// **'Irish Water Spaniel'**
  String get spanielIrish;

  /// No description provided for @spanielJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese Spaniel'**
  String get spanielJapanese;

  /// No description provided for @spanielSussex.
  ///
  /// In en, this message translates to:
  /// **'Sussex Spaniel'**
  String get spanielSussex;

  /// No description provided for @spanielWelsh.
  ///
  /// In en, this message translates to:
  /// **'Welsh Spaniel'**
  String get spanielWelsh;

  /// No description provided for @spitzIndian.
  ///
  /// In en, this message translates to:
  /// **'Indian Spitz'**
  String get spitzIndian;

  /// No description provided for @spitzJapanese.
  ///
  /// In en, this message translates to:
  /// **'Japanese Spitz'**
  String get spitzJapanese;

  /// No description provided for @springerEnglish.
  ///
  /// In en, this message translates to:
  /// **'English Springer'**
  String get springerEnglish;

  /// No description provided for @stbernard.
  ///
  /// In en, this message translates to:
  /// **'St. Bernard'**
  String get stbernard;

  /// No description provided for @terrierAmerican.
  ///
  /// In en, this message translates to:
  /// **'American Staffordshire Terrier'**
  String get terrierAmerican;

  /// No description provided for @terrierAustralian.
  ///
  /// In en, this message translates to:
  /// **'Australian Terrier'**
  String get terrierAustralian;

  /// No description provided for @terrierBedlington.
  ///
  /// In en, this message translates to:
  /// **'Bedlington Terrier'**
  String get terrierBedlington;

  /// No description provided for @terrierBorder.
  ///
  /// In en, this message translates to:
  /// **'Border Terrier'**
  String get terrierBorder;

  /// No description provided for @terrierCairn.
  ///
  /// In en, this message translates to:
  /// **'Cairn Terrier'**
  String get terrierCairn;

  /// No description provided for @terrierDandie.
  ///
  /// In en, this message translates to:
  /// **'Dandie Terrier'**
  String get terrierDandie;

  /// No description provided for @terrierFox.
  ///
  /// In en, this message translates to:
  /// **'Fox Terrier'**
  String get terrierFox;

  /// No description provided for @terrierIrish.
  ///
  /// In en, this message translates to:
  /// **'Irish Terrier'**
  String get terrierIrish;

  /// No description provided for @terrierKerryblue.
  ///
  /// In en, this message translates to:
  /// **'Kerry Blue Terrier'**
  String get terrierKerryblue;

  /// No description provided for @terrierLakeland.
  ///
  /// In en, this message translates to:
  /// **'Lakeland Terrier'**
  String get terrierLakeland;

  /// No description provided for @terrierNorfolk.
  ///
  /// In en, this message translates to:
  /// **'Norfolk Terrier'**
  String get terrierNorfolk;

  /// No description provided for @terrierNorwich.
  ///
  /// In en, this message translates to:
  /// **'Norwich Terrier'**
  String get terrierNorwich;

  /// No description provided for @terrierPatterdale.
  ///
  /// In en, this message translates to:
  /// **'Patterdale Terrier'**
  String get terrierPatterdale;

  /// No description provided for @terrierRussell.
  ///
  /// In en, this message translates to:
  /// **'Russell Terrier'**
  String get terrierRussell;

  /// No description provided for @terrierScottish.
  ///
  /// In en, this message translates to:
  /// **'Scottish Terrier'**
  String get terrierScottish;

  /// No description provided for @terrierSealyham.
  ///
  /// In en, this message translates to:
  /// **'Sealyham Terrier'**
  String get terrierSealyham;

  /// No description provided for @terrierSilky.
  ///
  /// In en, this message translates to:
  /// **'Silky Terrier'**
  String get terrierSilky;

  /// No description provided for @terrierTibetan.
  ///
  /// In en, this message translates to:
  /// **'Tibetan Terrier'**
  String get terrierTibetan;

  /// No description provided for @terrierToy.
  ///
  /// In en, this message translates to:
  /// **'Toy Terrier'**
  String get terrierToy;

  /// No description provided for @terrierWelsh.
  ///
  /// In en, this message translates to:
  /// **'Welsh Terrier'**
  String get terrierWelsh;

  /// No description provided for @terrierWesthighland.
  ///
  /// In en, this message translates to:
  /// **'West Highland Terrier'**
  String get terrierWesthighland;

  /// No description provided for @terrierWheaten.
  ///
  /// In en, this message translates to:
  /// **'Wheaten Terrier'**
  String get terrierWheaten;

  /// No description provided for @terrierYorkshire.
  ///
  /// In en, this message translates to:
  /// **'Yorkshire Terrier'**
  String get terrierYorkshire;

  /// No description provided for @tervuren.
  ///
  /// In en, this message translates to:
  /// **'Tervuren'**
  String get tervuren;

  /// No description provided for @vizsla.
  ///
  /// In en, this message translates to:
  /// **'Vizsla'**
  String get vizsla;

  /// No description provided for @waterdogSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish Waterdog'**
  String get waterdogSpanish;

  /// No description provided for @weimaraner.
  ///
  /// In en, this message translates to:
  /// **'Weimaraner'**
  String get weimaraner;

  /// No description provided for @whippet.
  ///
  /// In en, this message translates to:
  /// **'Whippet'**
  String get whippet;

  /// No description provided for @wolfhoundIrish.
  ///
  /// In en, this message translates to:
  /// **'Irish Wolfhound'**
  String get wolfhoundIrish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
