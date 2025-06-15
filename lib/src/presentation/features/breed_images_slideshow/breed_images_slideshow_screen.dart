import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../../domain/domain.dart';
import 'bloc/breed_images_slideshow_bloc.dart';
import 'breed_images_slideshow_body.dart';

/// Screen for displaying breed images in a slideshow format.
///
/// This screen implements User Story 2: "View All Images for a Specific Dog Breed
/// in a Performant, Interactive Slideshow" with features including:
/// - Full slideshow functionality with navigation
/// - Zoom and pan capabilities
/// - Thumbnail gallery
/// - Offline support
/// - Favorite functionality
@RoutePage()
class BreedImagesSlideshowScreen extends StatelessWidget {
  /// The breed to display images for.
  final BreedType breed;

  /// Creates an instance of [BreedImagesSlideshowScreen].
  const BreedImagesSlideshowScreen({required this.breed, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BreedImagesSlideshowBloc>(
      create: (BuildContext context) => BreedImagesSlideshowBloc(
        getBreedImagesUseCase: appLocator<GetBreedImagesUseCase>(),
        toggleFavoriteUseCase: appLocator<ToggleBreedImageFavoriteUseCase>(),
      )..add(LoadBreedImagesEvent(breed: breed)),
      child: BreedImagesSlideshowBody(breed: breed),
    );
  }
}
