import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../features/breed_images_slideshow/breed_images_slideshow_screen.dart';
import '../features/breed_list/breed_list_screen.dart';
import '../features/dog_details/dog_details_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';
import '../features/quiz/quiz_screen.dart';
import '../features/quiz_score/quiz_score_screen.dart';
import '../features/settings/settings_screen.dart';

part 'app_router.gr.dart';

/// The main application router configuration for Pawsitive Vibe Finder.
///
/// This class defines all navigation routes and their configurations using
/// the AutoRoute package. It provides type-safe navigation throughout the
/// application and supports various transition animations and route behaviors.
///
/// The router handles navigation between all major features:
/// - Home screen (dog discovery with swipeable cards)
/// - Breed list (comprehensive breed catalog)
/// - Favorites (user's liked dogs)
/// - Quiz (breed identification game)
/// - Settings (app preferences and configuration)
/// - Breed image slideshow (immersive image viewing)
/// - Dog details (detailed information about specific dogs)
///
/// Usage example:
/// ```dart
/// // Navigate to a specific route
/// context.router.navigate(const BreedListRoute());
///
/// // Navigate with parameters
/// context.router.navigate(HomeRoute(breed: BreedType.goldenRetriever));
///
/// // Navigate and replace current route
/// context.router.navigate(const FavoritesRoute());
/// ```
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  /// Defines the complete route configuration for the application.
  ///
  /// The routes are organized with the [HomeRoute] as the initial route,
  /// providing immediate access to the core dog discovery experience.
  /// Other routes support the full feature set of the application.
  ///
  /// Special considerations:
  /// - [HomeRoute] is marked as initial for first app launch
  /// - [DogDetailsRoute] uses a custom transition for seamless UX
  /// - All routes support deep linking and state restoration
  ///
  /// Returns a list of [AutoRoute] configurations that define the
  /// navigation structure and behavior for each screen.
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    /// Initial route - Home screen for dog discovery.
    ///
    /// Supports optional breed parameter for breed-specific viewing.
    AutoRoute(page: HomeRoute.page, initial: true),

    /// Breed list screen for browsing all available dog breeds.
    ///
    /// Includes search functionality and navigation to breed-specific content.
    AutoRoute(page: BreedListRoute.page),

    /// Favorites screen for viewing user's liked dogs.
    ///
    /// Displays a grid of favorite dog images with management options.
    AutoRoute(page: FavoritesRoute.page),

    /// Quiz screen for the breed identification game.
    ///
    /// Interactive quiz testing user's knowledge of dog breeds.
    AutoRoute(page: QuizRoute.page),

    /// Quiz score screen showing results after quiz completion.
    ///
    /// Displays score, correct answers, and options to replay.
    AutoRoute(page: QuizScoreRoute.page),

    /// Breed images slideshow for immersive image viewing.
    ///
    /// Full-screen image gallery with swipe navigation and favorites.
    AutoRoute(page: BreedImagesSlideshowRoute.page),

    /// Settings screen for app configuration and preferences.
    ///
    /// Includes theme selection, language settings, and other preferences.
    AutoRoute(page: SettingsRoute.page),

    /// Dog details screen with custom transition animation.
    ///
    /// Shows detailed information about a specific dog with smooth transitions.
    CustomRoute<void>(
      page: DogDetailsRoute.page,
      transitionsBuilder: (_, _, _, Widget child) => child,
    ),
  ];
}
