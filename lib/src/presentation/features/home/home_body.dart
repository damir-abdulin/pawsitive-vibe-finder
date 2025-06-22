import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../localization/locale_extension.dart';
import '../../widgets/app_bottom_navigation.dart';
import '../../widgets/image_card/image_card_controller.dart';
import 'bloc/home_bloc.dart';
import 'widgets/widgets.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({this.breed, super.key});

  final BreedType? breed;

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final ImageCardController _imageCardController = ImageCardController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is FirstLaunchState) {
          WelcomeBottomSheet.show(context, () {
            Navigator.of(context).pop();
          });
          context.read<HomeBloc>().add(CompleteFirstLaunchEvent());
        }
        if (state is ShowOfflineDialog) {
          _showOfflineDialog(context);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: <Widget>[
            // Sticky header
            const HomeHeader(),
            // Main content
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (BuildContext context, HomeState state) {
                  return switch (state) {
                    HomeLoading() => const HomeLoadingView(),
                    SubsequentLaunchState() => HomeImageView(
                      dogs: state.dogs,
                      controller: _imageCardController,
                    ),
                    HomeError() => HomeErrorState(
                      message: state.message,
                      onRetry: () =>
                          context.read<HomeBloc>().add(LoadHomeEvent()),
                    ),
                    FirstLaunchState() => const HomeFirstLaunchView(),
                    HomeInitial() => const HomeLoadingView(),
                    ShowOfflineDialog() => const HomeFirstLaunchView(),
                  };
                },
              ),
            ),
            // Bottom navigation
            const AppBottomNavigation(currentRoute: 'HomeRoute'),
          ],
        ),
      ),
    );
  }

  Future<void> _showOfflineDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            context.locale.noInternetConnection,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          content: Text(
            context.locale.offlineDialogMessage,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                context.locale.okButton,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
