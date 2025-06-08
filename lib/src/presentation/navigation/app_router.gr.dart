// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [BreedListScreen]
class BreedListRoute extends PageRouteInfo<void> {
  const BreedListRoute({List<PageRouteInfo>? children})
    : super(BreedListRoute.name, initialChildren: children);

  static const String name = 'BreedListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BreedListScreen();
    },
  );
}

/// generated route for
/// [DogDetailsScreen]
class DogDetailsRoute extends PageRouteInfo<DogDetailsRouteArgs> {
  DogDetailsRoute({
    required DogModel dog,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         DogDetailsRoute.name,
         args: DogDetailsRouteArgs(dog: dog, key: key),
         initialChildren: children,
       );

  static const String name = 'DogDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<DogDetailsRouteArgs>();
      return DogDetailsScreen(dog: args.dog, key: args.key);
    },
  );
}

class DogDetailsRouteArgs {
  const DogDetailsRouteArgs({required this.dog, this.key});

  final DogModel dog;

  final Key? key;

  @override
  String toString() {
    return 'DogDetailsRouteArgs{dog: $dog, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! DogDetailsRouteArgs) return false;
    return dog == other.dog && key == other.key;
  }

  @override
  int get hashCode => dog.hashCode ^ key.hashCode;
}

/// generated route for
/// [FavoritesScreen]
class FavoritesRoute extends PageRouteInfo<void> {
  const FavoritesRoute({List<PageRouteInfo>? children})
    : super(FavoritesRoute.name, initialChildren: children);

  static const String name = 'FavoritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavoritesScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({BreedType? breed, Key? key, List<PageRouteInfo>? children})
    : super(
        HomeRoute.name,
        args: HomeRouteArgs(breed: breed, key: key),
        initialChildren: children,
      );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomeScreen(breed: args.breed, key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.breed, this.key});

  final BreedType? breed;

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{breed: $breed, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return breed == other.breed && key == other.key;
  }

  @override
  int get hashCode => breed.hashCode ^ key.hashCode;
}

/// generated route for
/// [QuizScoreScreen]
class QuizScoreRoute extends PageRouteInfo<QuizScoreRouteArgs> {
  QuizScoreRoute({
    required int score,
    required int totalQuestions,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         QuizScoreRoute.name,
         args: QuizScoreRouteArgs(
           score: score,
           totalQuestions: totalQuestions,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'QuizScoreRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuizScoreRouteArgs>();
      return QuizScoreScreen(
        score: args.score,
        totalQuestions: args.totalQuestions,
        key: args.key,
      );
    },
  );
}

class QuizScoreRouteArgs {
  const QuizScoreRouteArgs({
    required this.score,
    required this.totalQuestions,
    this.key,
  });

  final int score;

  final int totalQuestions;

  final Key? key;

  @override
  String toString() {
    return 'QuizScoreRouteArgs{score: $score, totalQuestions: $totalQuestions, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QuizScoreRouteArgs) return false;
    return score == other.score &&
        totalQuestions == other.totalQuestions &&
        key == other.key;
  }

  @override
  int get hashCode => score.hashCode ^ totalQuestions.hashCode ^ key.hashCode;
}

/// generated route for
/// [QuizScreen]
class QuizRoute extends PageRouteInfo<void> {
  const QuizRoute({List<PageRouteInfo>? children})
    : super(QuizRoute.name, initialChildren: children);

  static const String name = 'QuizRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const QuizScreen();
    },
  );
}
