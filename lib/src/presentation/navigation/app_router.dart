import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import '../features/breed_list/breed_list_screen.dart';
import '../features/dog_details/dog_details_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';
import '../features/quiz/quiz_screen.dart';
import '../features/quiz_score/quiz_score_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: BreedListRoute.page),
    AutoRoute(page: FavoritesRoute.page),
    AutoRoute(page: QuizRoute.page),
    AutoRoute(page: QuizScoreRoute.page),
    CustomRoute<void>(
      page: DogDetailsRoute.page,
      transitionsBuilder: (_, _, _, Widget child) => child,
    ),
  ];
}
