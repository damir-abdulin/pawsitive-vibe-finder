import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../../domain/breed/use_case/get_breeds_use_case.dart';
import 'bloc/breed_list_bloc.dart';
import 'bloc/breed_list_event.dart';
import 'widgets/breed_list_body.dart';

@RoutePage()
/// The screen that displays the list of dog breeds.
class BreedListScreen extends StatelessWidget {
  /// Creates a [BreedListScreen].
  const BreedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BreedListBloc>(
      create: (context) =>
          BreedListBloc(getBreedsUseCase: appLocator<GetBreedsUseCase>())
            ..add(BreedListFetchRequested()),
      child: const BreedListBody(),
    );
  }
}
