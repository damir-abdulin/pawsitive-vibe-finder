part of 'breed_images_slideshow_bloc.dart';

/// Base class for all breed images slideshow events.
abstract class BreedImagesSlideshowEvent {
  const BreedImagesSlideshowEvent();
}

/// Event to load the initial breed images gallery.
class LoadBreedImagesEvent extends BreedImagesSlideshowEvent {
  /// The breed to load images for.
  final BreedType breed;

  /// Creates a [LoadBreedImagesEvent].
  const LoadBreedImagesEvent({required this.breed});
}

/// Event to navigate to the next image in the slideshow.
class NavigateToNextImageEvent extends BreedImagesSlideshowEvent {
  const NavigateToNextImageEvent();
}

/// Event to navigate to the previous image in the slideshow.
class NavigateToPreviousImageEvent extends BreedImagesSlideshowEvent {
  const NavigateToPreviousImageEvent();
}

/// Event to navigate to a specific image by index.
class NavigateToImageEvent extends BreedImagesSlideshowEvent {
  /// The index of the image to navigate to.
  final int imageIndex;

  /// Creates a [NavigateToImageEvent].
  const NavigateToImageEvent({required this.imageIndex});
}

/// Event to toggle the favorite status of the current image.
class ToggleFavoriteEvent extends BreedImagesSlideshowEvent {
  const ToggleFavoriteEvent();
}

/// Event to handle zoom state changes.
class ZoomStateChangedEvent extends BreedImagesSlideshowEvent {
  /// Whether the image is currently zoomed.
  final bool isZoomed;

  /// Creates a [ZoomStateChangedEvent].
  const ZoomStateChangedEvent({required this.isZoomed});
}

/// Event to retry loading images after an error.
class RetryLoadingEvent extends BreedImagesSlideshowEvent {
  const RetryLoadingEvent();
}
