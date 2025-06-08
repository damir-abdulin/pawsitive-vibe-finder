import 'package:auto_route/auto_route.dart';

import '../features/breed_list/breed_list_screen.dart';
import '../features/favorites/favorites_screen.dart';
import '../features/home/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: BreedListRoute.page, path: '/breed-list', initial: true),
    AutoRoute(page: FavoritesRoute.page, path: '/favorites'),
    AutoRoute(page: HomeRoute.page, path: '/home'),
  ];
}
