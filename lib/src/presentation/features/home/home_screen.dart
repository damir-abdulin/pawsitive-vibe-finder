import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/service_locator.dart';
import 'bloc/home_bloc.dart';
import 'home_body.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) => HomeBloc(
        getRandomDogsUseCase: appLocator(),
        checkFirstLaunchUseCase: appLocator(),
        setFirstLaunchCompletedUseCase: appLocator(),
        saveFavoriteDogUseCase: appLocator(),
        saveLastDogUseCase: appLocator(),
        getLastDogUseCase: appLocator(),
      )..add(LoadHomeEvent()),
      child: const HomeBody(),
    );
  }
}
