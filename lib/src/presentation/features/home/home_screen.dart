import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawsitive_vibe_finder/src/di/service_locator.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/home/bloc/home_bloc.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/home/home_body.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (BuildContext context) =>
          appLocator<HomeBloc>()..add(LoadHomeEvent()),
      child: HomeBody(),
    );
  }
}
