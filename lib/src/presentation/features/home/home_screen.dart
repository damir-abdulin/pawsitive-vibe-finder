import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/service_locator.dart';
import '../../../domain/models/models.dart';
import 'bloc/home_bloc.dart';
import 'home_body.dart';

/// The main home screen of the Pawsitive Vibe Finder application.
///
/// This screen serves as the primary entry point for users and implements
/// the core dog discovery experience with swipeable cards. It handles both
/// first-time user onboarding and subsequent app launches with different UI states.
///
/// Features:
/// - Swipeable dog image cards (Tinder-like interaction)
/// - First launch welcome experience
/// - Random dog fetching and display
/// - Favorite management integration
/// - Breed-specific filtering when navigating from breed list
/// - Offline support with cached data
/// - BLoC state management for complex UI states
///
/// The screen uses [AutoRoute] for navigation and [BlocProvider] to manage
/// state through the [HomeBloc]. It can optionally display dogs of a specific
/// breed when the [breed] parameter is provided.
///
/// Navigation example:
/// ```dart
/// // Navigate to general home screen
/// context.router.navigate(HomeRoute());
///
/// // Navigate to breed-specific home screen
/// context.router.navigate(HomeRoute(breed: BreedType.goldenRetriever));
/// ```
@RoutePage()
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen] widget.
  ///
  /// If [breed] is provided, the screen will display dogs of that specific
  /// breed only. If [breed] is null, the screen displays random dogs from
  /// all breeds.
  const HomeScreen({this.breed, super.key});

  /// Optional breed filter for displaying breed-specific dogs.
  ///
  /// When provided, the home screen will only show dogs of this specific
  /// breed. This is typically used when navigating from the breed list
  /// screen to see dogs of a particular breed.
  ///
  /// When null, the screen displays random dogs from all available breeds.
  final BreedType? breed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(
        getRandomDogsUseCase: appLocator(),
        checkFirstLaunchUseCase: appLocator(),
        setFirstLaunchCompletedUseCase: appLocator(),
        saveFavoriteDogUseCase: appLocator(),
        saveLastDogUseCase: appLocator(),
        getLastDogUseCase: appLocator(),
        breed: breed,
      )..add(LoadHomeEvent()),
      child: HomeBody(breed: breed),
    );
  }
}
