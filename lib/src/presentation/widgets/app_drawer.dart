import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../localization/locale_extension.dart';
import '../navigation/app_router.dart';

/// The main navigation drawer for the application.
class AppDrawer extends StatelessWidget {
  /// Creates an [AppDrawer].
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Text(
              context.locale.drawerTitle,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(context.locale.drawerHome),
            onTap: () {
              context.router.replace(HomeRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: Text(context.locale.drawerBreeds),
            onTap: () {
              context.router.replace(const BreedListRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(context.locale.drawerFavorites),
            onTap: () {
              context.router.replace(const FavoritesRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.psychology),
            title: const Text('Guess the Breed'),
            onTap: () {
              context.router.replace(const QuizRoute());
            },
          ),
        ],
      ),
    );
  }
}
