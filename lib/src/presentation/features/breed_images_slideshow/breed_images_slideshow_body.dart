import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';

import 'bloc/breed_images_slideshow_bloc.dart';
import 'widgets/breed_images_slideshow_widgets.dart';

/// The main body widget for the breed images slideshow.
///
/// This widget implements the core UI requirements from User Story 2:
/// - AppBar with breed name and back button (AC-1)
/// - Main image display with navigation (AC-2)
/// - Gallery counter and favorite button (AC-3)
/// - Zoom and pan functionality (AC-5)
/// - Thumbnail gallery (AC-6)
class BreedImagesSlideshowBody extends StatelessWidget {
  /// The breed being displayed.
  final BreedType breed;

  /// Creates an instance of [BreedImagesSlideshowBody].
  const BreedImagesSlideshowBody({required this.breed, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getBreedDisplayName(breed)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: BlocBuilder<BreedImagesSlideshowBloc, BreedImagesSlideshowState>(
        builder: (BuildContext context, BreedImagesSlideshowState state) {
          return switch (state) {
            BreedImagesSlideshowInitial() || BreedImagesSlideshowLoading() =>
              const Center(child: CircularProgressIndicator()),

            BreedImagesSlideshowLoaded() => _buildLoadedState(context, state),

            BreedImagesSlideshowEmpty() => _buildEmptyState(context, state),

            BreedImagesSlideshowError() => _buildErrorState(context, state),
          };
        },
      ),
    );
  }

  /// Builds the UI when images are successfully loaded.
  Widget _buildLoadedState(
    BuildContext context,
    BreedImagesSlideshowLoaded state,
  ) {
    return Column(
      children: <Widget>[
        // Gallery counter and liked indicator (AC-3)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Image ${state.currentIndex + 1} of ${state.totalImages}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              if (state.currentImage.isFavorite) ...<Widget>[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.red.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.favorite, size: 16, color: Colors.red),
                      SizedBox(width: 4),
                      Text(
                        'Liked',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),

        // Main image display with zoom/pan and navigation (AC-2, AC-5)
        Expanded(
          flex: 3,
          child: SlideshowImageDisplay(
            imageUrl: state.currentImage.imageUrl,
            isZoomed: state.isZoomed,
            onZoomChanged: (bool isZoomed) {
              context.read<BreedImagesSlideshowBloc>().add(
                ZoomStateChangedEvent(isZoomed: isZoomed),
              );
            },
            onSwipeLeft: () {
              context.read<BreedImagesSlideshowBloc>().add(
                NavigateToNextImageEvent(),
              );
            },
            onSwipeRight: () {
              context.read<BreedImagesSlideshowBloc>().add(
                NavigateToPreviousImageEvent(),
              );
            },
          ),
        ),

        // Navigation controls (AC-2)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Previous button
              SlideshowNavigationButton(
                icon: Icons.arrow_back_ios,
                onPressed: state.isZoomed
                    ? null
                    : () {
                        context.read<BreedImagesSlideshowBloc>().add(
                          NavigateToPreviousImageEvent(),
                        );
                      },
                tooltip: 'Previous Image',
              ),

              // Favorite button (AC-3)
              SlideshowFavoriteButton(
                isFavorite: state.currentImage.isFavorite,
                onPressed: () {
                  context.read<BreedImagesSlideshowBloc>().add(
                    ToggleFavoriteEvent(),
                  );
                },
              ),

              // Next button
              SlideshowNavigationButton(
                icon: Icons.arrow_forward_ios,
                onPressed: state.isZoomed
                    ? null
                    : () {
                        context.read<BreedImagesSlideshowBloc>().add(
                          NavigateToNextImageEvent(),
                        );
                      },
                tooltip: 'Next Image',
              ),
            ],
          ),
        ),

        // Thumbnail gallery (AC-6)
        SizedBox(
          height: 100,
          child: SlideshowThumbnailGallery(
            images: state.breedImages.images,
            currentIndex: state.currentIndex,
            onThumbnailTapped: (int index) {
              context.read<BreedImagesSlideshowBloc>().add(
                NavigateToImageEvent(imageIndex: index),
              );
            },
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  /// Builds the UI when no images are found.
  Widget _buildEmptyState(
    BuildContext context,
    BreedImagesSlideshowEmpty state,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No barks about it, we could not find any images for this breed!',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<BreedImagesSlideshowBloc>().add(
                LoadBreedImagesEvent(breed: state.breed),
              );
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  /// Builds the UI when an error occurs.
  Widget _buildErrorState(
    BuildContext context,
    BreedImagesSlideshowError state,
  ) {
    String message = state.message;
    if (state.isOfflineError) {
      message =
          'You are currently offline. Please connect to the internet to discover new pups!';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              state.isOfflineError ? Icons.wifi_off : Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (!state.isOfflineError)
              ElevatedButton(
                onPressed: () {
                  context.read<BreedImagesSlideshowBloc>().add(
                    RetryLoadingEvent(),
                  );
                },
                child: const Text('Try Again'),
              ),
          ],
        ),
      ),
    );
  }

  /// Converts a BreedType to a user-friendly display name.
  String _getBreedDisplayName(BreedType breed) {
    // Convert enum name to readable format
    // e.g., 'bulldog' -> 'Bulldog', 'goldenRetriever' -> 'Golden Retriever'
    final String name = breed.name;

    // Split camelCase into words
    final String result = name.replaceAllMapped(
      RegExp('([A-Z])'),
      (Match match) => ' ${match.group(1)}',
    );

    // Capitalize first letter
    return result.isEmpty
        ? name
        : result[0].toUpperCase() + result.substring(1);
  }
}
