import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../widgets/app_drawer.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text('Favorite Dogs'),
      ),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Favorites Screen')),
    );
  }
}
