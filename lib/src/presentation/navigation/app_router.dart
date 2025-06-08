import 'package:auto_route/auto_route.dart';

import '../features/breed_list/breed_list_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: BreedListRoute.page),
    AutoRoute(page: FavoritesRoute.page),
  ];
}
