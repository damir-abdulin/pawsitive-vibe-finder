import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../localization/locale_extension.dart';
import '../../widgets/app_drawer.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Text(context.locale.favoritesTitle),
      ),
      drawer: const AppDrawer(),
      body: Center(child: Text(context.locale.favoritesScreenMessage)),
    );
  }
}
