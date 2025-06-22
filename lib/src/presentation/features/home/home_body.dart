import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../widgets/app_bottom_navigation.dart';
import '../../widgets/image_card/image_card_controller.dart';
import '../../localization/locale_extension.dart';
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
                    HomeLoading() => const HomeLoadingWidget(),
                    SubsequentLaunchState() => _buildImageView(
                      context,
                      state.dogs,
                    ),
                    HomeError() => HomeErrorState(
                      message: state.message,
                      onRetry: () =>
                          context.read<HomeBloc>().add(LoadHomeEvent()),
                    ),
                    FirstLaunchState() => _buildFirstLaunchView(context),
                    HomeInitial() => const HomeLoadingWidget(),
                    ShowOfflineDialog() => _buildFirstLaunchView(context),
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

  Widget _buildImageView(BuildContext context, List<DogModel> dogs) {
    if (dogs.isEmpty) {
      return const HomeLoadingWidget();
    }

    final DogModel currentDog = dogs.first;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 8),
          // Stack of dog image cards with swipe functionality
          Expanded(
            child: Center(
              child: HomeImageStack(
                dogs: dogs,
                controller: _imageCardController,
                onSwipeRight: () => context.read<HomeBloc>().add(
                  SwipeRightEvent(dog: currentDog),
                ),
                onSwipeLeft: () => context.read<HomeBloc>().add(
                  SwipeLeftEvent(dog: currentDog),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Breed info
          HomeBreedInfo(dog: currentDog),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFirstLaunchView(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(
          scale: value,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.pets,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.locale.welcomeToApp,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    context.locale.pawsitivityMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
