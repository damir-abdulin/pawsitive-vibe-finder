import 'package:flutter/material.dart';

/// Events that can be triggered on an [ImageCard] through its controller.
///
/// These events allow programmatic control of card swiping behavior
/// without requiring direct user interaction.
enum ImageCardEvent {
  /// Triggers a right swipe animation (like gesture).
  swipeRight,

  /// Triggers a left swipe animation (pass gesture).
  swipeLeft,
}

/// A controller for managing [ImageCard] interactions programmatically.
///
/// This controller extends [ValueNotifier] to provide a reactive way
/// to trigger swipe animations on [ImageCard] widgets from external code.
/// It's particularly useful for implementing action buttons that can
/// trigger the same animations as user gestures.
///
/// Example usage:
/// ```dart
/// final ImageCardController controller = ImageCardController();
///
/// // Later in your code:
/// controller.swipeRight(); // Triggers right swipe animation
/// controller.swipeLeft();  // Triggers left swipe animation
/// ```
class ImageCardController extends ValueNotifier<ImageCardEvent?> {
  /// Creates an [ImageCardController].
  ///
  /// The controller starts with no event (null value).
  ImageCardController() : super(null);

  /// Triggers a right swipe animation on the controlled [ImageCard].
  ///
  /// This method programmatically initiates the same animation that
  /// would occur if the user swiped the card to the right.
  /// The associated [ImageCard.onSwipeRight] callback will be called
  /// when the animation completes.
  void swipeRight() {
    value = ImageCardEvent.swipeRight;
  }

  /// Triggers a left swipe animation on the controlled [ImageCard].
  ///
  /// This method programmatically initiates the same animation that
  /// would occur if the user swiped the card to the left.
  /// The associated [ImageCard.onSwipeLeft] callback will be called
  /// when the animation completes.
  void swipeLeft() {
    value = ImageCardEvent.swipeLeft;
  }

  @override
  ImageCardEvent? get value {
    final ImageCardEvent? event = super.value;
    super.value = null;

    return event;
  }
}
