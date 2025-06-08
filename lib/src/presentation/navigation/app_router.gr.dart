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
