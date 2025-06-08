import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../features/breed_list/breed_list_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: HomeRoute.page, path: '/home', initial: true),
    AutoRoute(page: BreedListRoute.page, path: '/breed-list'),
    AutoRoute(page: FavoritesRoute.page, path: '/favorites'),
  ];
}
