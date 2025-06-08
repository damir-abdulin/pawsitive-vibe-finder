import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

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
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Pawsitive Vibe Finder',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.router.replace(const HomeRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Breeds'),
            onTap: () {
              context.router.replace(const BreedListRoute());
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () {
              context.router.replace(const FavoritesRoute());
            },
          ),
        ],
      ),
    );
  }
}
