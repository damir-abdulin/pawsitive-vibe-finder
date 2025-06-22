import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../../theme/app_constants.dart';
import '../../../widgets/image_card/image_card_controller.dart';
import '../bloc/home_bloc.dart';
import 'home_breed_info.dart';
import 'home_image_stack.dart';

/// Widget that displays the dog images view with swipe functionality.
class HomeImageView extends StatelessWidget {
  /// Creates a [HomeImageView].
  const HomeImageView({
    required this.dogs,
    required this.controller,
    super.key,
  });

  /// The list of dogs to display.
  final List<DogModel> dogs;

  /// Controller for the image cards.
  final ImageCardController controller;

  @override
  Widget build(BuildContext context) {
    if (dogs.isEmpty) {
      return const SizedBox.shrink();
    }

    final DogModel currentDog = dogs.first;

    return Padding(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      child: Column(
        children: <Widget>[
          const SizedBox(height: AppConstants.smallPadding),
          // Stack of dog image cards with swipe functionality
          Expanded(
            child: Center(
              child: HomeImageStack(
                dogs: dogs,
                controller: controller,
                onSwipeRight: () => context.read<HomeBloc>().add(
                  SwipeRightEvent(dog: currentDog),
                ),
                onSwipeLeft: () => context.read<HomeBloc>().add(
                  SwipeLeftEvent(dog: currentDog),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.largePadding),
          // Breed info
          HomeBreedInfo(dog: currentDog),
          const SizedBox(height: AppConstants.mediumPadding),
        ],
      ),
    );
  }
}
