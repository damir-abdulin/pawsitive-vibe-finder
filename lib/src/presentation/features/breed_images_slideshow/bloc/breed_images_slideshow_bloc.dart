import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/domain.dart';

part 'breed_images_slideshow_event.dart';
part 'breed_images_slideshow_state.dart';

/// BLoC for managing the breed images slideshow functionality.
///
/// This BLoC handles all the slideshow operations including:
/// - Loading breed images from API or cache
/// - Navigation between images (next/previous/specific index)
/// - Favoriting images
/// - Zoom state management
/// - Loop navigation as specified in User Story 2
class BreedImagesSlideshowBloc
    extends Bloc<BreedImagesSlideshowEvent, BreedImagesSlideshowState> {
  final GetBreedImagesUseCase _getBreedImagesUseCase;
  final ToggleBreedImageFavoriteUseCase _toggleFavoriteUseCase;

  /// Creates an instance of [BreedImagesSlideshowBloc].
  BreedImagesSlideshowBloc({
    required GetBreedImagesUseCase getBreedImagesUseCase,
    required ToggleBreedImageFavoriteUseCase toggleFavoriteUseCase,
  }) : _getBreedImagesUseCase = getBreedImagesUseCase,
       _toggleFavoriteUseCase = toggleFavoriteUseCase,
       super(BreedImagesSlideshowInitial()) {
    on<LoadBreedImagesEvent>(_onLoadBreedImages);
    on<NavigateToNextImageEvent>(_onNavigateToNextImage);
    on<NavigateToPreviousImageEvent>(_onNavigateToPreviousImage);
    on<NavigateToImageEvent>(_onNavigateToImage);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
    on<ZoomStateChangedEvent>(_onZoomStateChanged);
    on<RetryLoadingEvent>(_onRetryLoading);
  }

  /// Handles loading breed images from API or cache.
  Future<void> _onLoadBreedImages(
    LoadBreedImagesEvent event,
    Emitter<BreedImagesSlideshowState> emit,
  ) async {
    emit(BreedImagesSlideshowLoading());

    try {
      final GetBreedImagesInput input = GetBreedImagesInput(breed: event.breed);
      final BreedImagesModel breedImages = await _getBreedImagesUseCase.execute(
        input,
        onError: (AppException exception) async {
          throw exception; // Re-throw to be caught by the outer try-catch
        },
      );

      if (!breedImages.hasImages) {
        emit(BreedImagesSlideshowEmpty(breed: event.breed));
        return;
      }

      emit(
        BreedImagesSlideshowLoaded(
          breedImages: breedImages,
          currentIndex: 0, // Start with the first image
        ),
      );
    } on BreedImagesException catch (e) {
      final bool isOfflineError = e.message?.contains('offline') ?? false;
      emit(
        BreedImagesSlideshowError(
          message: e.message ?? 'Failed to load images',
          breed: event.breed,
          isOfflineError: isOfflineError,
        ),
      );
    } catch (e) {
      emit(
        BreedImagesSlideshowError(
          message: 'An unexpected error occurred: $e',
          breed: event.breed,
        ),
      );
    }
  }

  /// Handles navigation to the next image with loop support (AC-4.1).
  void _onNavigateToNextImage(
    NavigateToNextImageEvent event,
    Emitter<BreedImagesSlideshowState> emit,
  ) {
    if (state is BreedImagesSlideshowLoaded) {
      final BreedImagesSlideshowLoaded currentState =
          state as BreedImagesSlideshowLoaded;

      // Disable navigation if zoomed (AC-5)
      if (currentState.isZoomed) return;

      int nextIndex;
      if (currentState.isLastImage) {
        // Loop to first image (AC-4.1)
        nextIndex = 0;
      } else {
        nextIndex = currentState.currentIndex + 1;
      }

      emit(currentState.copyWith(currentIndex: nextIndex));
    }
  }

  /// Handles navigation to the previous image with loop support (AC-4.2).
  void _onNavigateToPreviousImage(
    NavigateToPreviousImageEvent event,
    Emitter<BreedImagesSlideshowState> emit,
  ) {
    if (state is BreedImagesSlideshowLoaded) {
      final BreedImagesSlideshowLoaded currentState =
          state as BreedImagesSlideshowLoaded;

      // Disable navigation if zoomed (AC-5)
      if (currentState.isZoomed) return;

      int previousIndex;
      if (currentState.isFirstImage) {
        // Loop to last image (AC-4.2)
        previousIndex = currentState.totalImages - 1;
      } else {
        previousIndex = currentState.currentIndex - 1;
      }

      emit(currentState.copyWith(currentIndex: previousIndex));
    }
  }

  /// Handles navigation to a specific image index (AC-6).
  void _onNavigateToImage(
    NavigateToImageEvent event,
    Emitter<BreedImagesSlideshowState> emit,
  ) {
    if (state is BreedImagesSlideshowLoaded) {
      final BreedImagesSlideshowLoaded currentState =
          state as BreedImagesSlideshowLoaded;

      // Validate index bounds
      if (event.imageIndex >= 0 &&
          event.imageIndex < currentState.totalImages) {
        emit(
          currentState.copyWith(
            currentIndex: event.imageIndex,
            isZoomed: false, // Reset zoom when navigating via thumbnail
          ),
        );
      }
    }
  }

  /// Handles toggling the favorite status of the current image (AC-3).
  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<BreedImagesSlideshowState> emit,
  ) async {
    if (state is BreedImagesSlideshowLoaded) {
      final BreedImagesSlideshowLoaded currentState =
          state as BreedImagesSlideshowLoaded;

      try {
        final ToggleBreedImageFavoriteInput input =
            ToggleBreedImageFavoriteInput(
              breedImage: currentState.currentImage,
            );

        final BreedImageModel updatedImage = await _toggleFavoriteUseCase
            .execute(
              input,
              onError: (AppException exception) async {
                // If favoriting fails, just log it but don't disrupt the UI
                return currentState.currentImage; // Return unchanged
              },
            );

        // Update the images collection with the new favorite status
        final BreedImagesModel updatedCollection = currentState.breedImages
            .updateImage(currentState.currentIndex, updatedImage);

        emit(currentState.copyWith(breedImages: updatedCollection));
      } catch (e) {
        // Favoriting failures should not disrupt the slideshow experience
        // In a real app, you might want to show a brief toast or indicator
      }
    }
  }

  /// Handles zoom state changes (AC-5).
  void _onZoomStateChanged(
    ZoomStateChangedEvent event,
    Emitter<BreedImagesSlideshowState> emit,
  ) {
    if (state is BreedImagesSlideshowLoaded) {
      final BreedImagesSlideshowLoaded currentState =
          state as BreedImagesSlideshowLoaded;
      emit(currentState.copyWith(isZoomed: event.isZoomed));
    }
  }

  /// Handles retry loading after an error.
  void _onRetryLoading(
    RetryLoadingEvent event,
    Emitter<BreedImagesSlideshowState> emit,
  ) {
    if (state is BreedImagesSlideshowError) {
      final BreedImagesSlideshowError errorState =
          state as BreedImagesSlideshowError;
      if (errorState.breed != null) {
        add(LoadBreedImagesEvent(breed: errorState.breed!));
      }
    }
  }
}
