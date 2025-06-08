import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../localization/locale_extension.dart';
import '../../widgets/app_drawer.dart';
import 'bloc/favorites_bloc.dart';
import 'favorites_body.dart';

@RoutePage()
/// The main screen for the favorites feature.
///
/// This screen sets up the [FavoritesBloc] and provides the basic UI structure,
/// including the [AppBar].
class FavoritesScreen extends StatelessWidget {
  /// Creates a [FavoritesScreen] instance.
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoritesBloc>(
      create: (BuildContext context) => FavoritesBloc(
        getFavoriteDogsUseCase: appLocator(),
        saveFavoriteDogUseCase: appLocator(),
        removeFavoriteDogUseCase: appLocator(),
      )..add(FavoritesStarted()),
      child: Scaffold(
        appBar: AppBar(title: Text(context.locale.favoritesTitle)),
        drawer: const AppDrawer(),
        body: const FavoritesBody(),
      ),
    );
  }
}
