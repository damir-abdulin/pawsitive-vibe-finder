part of 'breed_images_slideshow_bloc.dart';

/// Base class for all breed images slideshow states.
sealed class BreedImagesSlideshowState extends Equatable {
  const BreedImagesSlideshowState();

  @override
  List<Object> get props => <Object>[];
}

/// Initial state when the slideshow is first created.
class BreedImagesSlideshowInitial extends BreedImagesSlideshowState {}

/// State when loading breed images from API or cache.
class BreedImagesSlideshowLoading extends BreedImagesSlideshowState {}

/// State when images are successfully loaded and displayed.
class BreedImagesSlideshowLoaded extends BreedImagesSlideshowState {
  /// The collection of breed images.
  final BreedImagesModel breedImages;

  /// The current image index being displayed.
  final int currentIndex;

  /// Whether the current image is zoomed.
  final bool isZoomed;

  /// The current breed being displayed.
  BreedType get currentBreed => breedImages.breed;

  /// The current image being displayed.
  BreedImageModel get currentImage => breedImages.images[currentIndex];

  /// Whether there are any images to display.
  bool get hasImages => breedImages.hasImages;

  /// Total number of images in the collection.
  int get totalImages => breedImages.totalCount;

  /// Whether this is the first image.
  bool get isFirstImage => currentIndex == 0;

  /// Whether this is the last image.
  bool get isLastImage => currentIndex == totalImages - 1;

  /// Creates a [BreedImagesSlideshowLoaded] state.
  const BreedImagesSlideshowLoaded({
    required this.breedImages,
    required this.currentIndex,
    this.isZoomed = false,
  });

  /// Creates a copy of this state with updated values.
  BreedImagesSlideshowLoaded copyWith({
    BreedImagesModel? breedImages,
    int? currentIndex,
    bool? isZoomed,
  }) {
    return BreedImagesSlideshowLoaded(
      breedImages: breedImages ?? this.breedImages,
      currentIndex: currentIndex ?? this.currentIndex,
      isZoomed: isZoomed ?? this.isZoomed,
    );
  }

  @override
  List<Object> get props => <Object>[breedImages, currentIndex, isZoomed];
}

/// State when an error occurs during loading or operations.
class BreedImagesSlideshowError extends BreedImagesSlideshowState {
  /// The error message to display.
  final String message;

  /// The breed that failed to load (for retry purposes).
  final BreedType? breed;

  /// Whether this is an offline error.
  final bool isOfflineError;

  /// Creates a [BreedImagesSlideshowError] state.
  const BreedImagesSlideshowError({
    required this.message,
    this.breed,
    this.isOfflineError = false,
  });

  @override
  List<Object> get props => <Object>[message, breed ?? '', isOfflineError];
}

/// State when no images are found for the breed.
class BreedImagesSlideshowEmpty extends BreedImagesSlideshowState {
  /// The breed that has no images.
  final BreedType breed;

  /// Creates a [BreedImagesSlideshowEmpty] state.
  const BreedImagesSlideshowEmpty({required this.breed});

  @override
  List<Object> get props => <Object>[breed];
}
