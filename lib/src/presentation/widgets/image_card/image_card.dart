import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../localization/locale_extension.dart';
import '../../theme/app_constants.dart';
import 'image_card_controller.dart';

/// A swipeable card widget for displaying dog images with Tinder-like interactions.
///
/// This widget allows users to swipe left or right on dog images, providing
/// visual feedback through rotation and stamp overlays. It's commonly used
/// in the home screen for the main dog discovery experience.
///
/// Features:
/// - Swipe gestures (left/right) with visual feedback
/// - Cached network image loading with placeholder and error states
/// - Card rotation based on swipe direction
/// - Customizable swipe callbacks
/// - External controller support for programmatic swiping
///
/// Example usage:
/// ```dart
/// ImageCard(
///   imageUrl: 'https://example.com/dog.jpg',
///   title: 'Golden Retriever',
///   onSwipeRight: () => print('Liked!'),
///   onSwipeLeft: () => print('Passed!'),
/// )
/// ```
class ImageCard extends StatefulWidget {
  /// Creates an [ImageCard] widget.
  ///
  /// The [imageUrl] parameter is required and must not be null.
  const ImageCard({
    required this.imageUrl,
    this.controller,
    this.title,
    this.duration = AppConstants.defaultAnimationDuration,
    this.dragBorder = AppConstants.dragBorderThreshold,
    this.onSwipeRight,
    this.onSwipeLeft,
    super.key,
  });

  /// The URL of the image to display in the card.
  final String imageUrl;

  /// Optional title text to display at the bottom of the card.
  final String? title;

  /// Optional controller for programmatic control of card swiping.
  ///
  /// When provided, allows external widgets to trigger swipe animations
  /// without user interaction.
  final ImageCardController? controller;

  /// Duration of the swipe animation.
  ///
  /// Defaults to [AppConstants.defaultAnimationDuration].
  final Duration duration;

  /// The minimum drag distance required to trigger a swipe.
  ///
  /// Defaults to [AppConstants.dragBorderThreshold].
  final double dragBorder;

  /// Callback fired when the card is swiped right (like gesture).
  final VoidCallback? onSwipeRight;

  /// Callback fired when the card is swiped left (pass gesture).
  final VoidCallback? onSwipeLeft;

  @override
  State<ImageCard> createState() => ImageCardState();
}

/// The state class for [ImageCard].
///
/// Manages animation controllers, drag handling, and swipe interactions.
/// This class is exposed to allow for testing and advanced customization.
class ImageCardState extends State<ImageCard>
    with SingleTickerProviderStateMixin {
  /// Animation controller for managing card transitions.
  late AnimationController _animationController;

  /// Current animation for card movement.
  Animation<Offset>? _animation;

  /// Current drag offset from the center position.
  Offset _dragOffset = Offset.zero;

  /// Whether the swipe animation has completed.
  bool _swipeCompleted = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(
          vsync: this,
          duration: AppConstants.defaultAnimationDuration,
        )..addListener(() {
          setState(() {});
        });

    widget.controller?.addListener(_onChangeImageController);
  }

  @override
  void didUpdateWidget(covariant ImageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != oldWidget.imageUrl) {
      _animationController.reset();
      _dragOffset = Offset.zero;
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onChangeImageController);
    _animationController.dispose();
    super.dispose();
  }

  /// Handles pan update events during drag gestures.
  ///
  /// Updates the card position based on horizontal drag movement.
  /// Vertical movement is ignored to maintain card behavior consistency.
  void _onPanUpdate(DragUpdateDetails details) {
    if (_animationController.isAnimating) return;
    setState(() {
      _dragOffset = Offset(_dragOffset.dx + details.delta.dx, 0);
    });
  }

  /// Handles pan end events when user releases drag gesture.
  ///
  /// Determines whether to complete the swipe or return to center
  /// based on the drag velocity and current position.
  void _onPanEnd(DragEndDetails details) {
    final Offset dragVector = details.velocity.pixelsPerSecond;

    if (dragVector.dx.abs() > AppConstants.dragBorderThreshold) {
      // Start animation only if swipe is fast enough
      final double screenWidth = MediaQuery.of(context).size.width;
      final bool isSwipeRight = dragVector.dx > 0;
      final double targetX = isSwipeRight
          ? screenWidth * 1.5
          : -screenWidth * 1.5;

      _triggerSwipe(
        isSwipeRight: isSwipeRight,
        beginOffset: _dragOffset,
        endOffset: Offset(targetX, _dragOffset.dy),
      );
    } else {
      // Animate back to center
      _animation = Tween<Offset>(begin: _dragOffset, end: Offset.zero).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
      _animationController.forward().whenComplete(() {
        setState(() {
          _dragOffset = Offset.zero;
          _animationController.reset();
        });
      });
    }
  }

  /// Triggers a swipe animation in the specified direction.
  ///
  /// [isSwipeRight] determines the swipe direction (true for right, false for left).
  /// [beginOffset] is the starting position for the animation.
  /// [endOffset] is the target position for the animation.
  void _triggerSwipe({
    required bool isSwipeRight,
    Offset? beginOffset,
    Offset? endOffset,
  }) {
    if (_animationController.isAnimating) return;

    final Offset begin = beginOffset ?? Offset.zero;
    final Offset end;

    if (endOffset != null) {
      end = endOffset;
    } else {
      final double screenWidth = MediaQuery.of(context).size.width;
      final double targetX = isSwipeRight
          ? screenWidth * 1.5
          : -screenWidth * 1.5;
      end = Offset(targetX, 0);
    }

    _animation = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward().whenComplete(() {
      if (isSwipeRight) {
        widget.onSwipeRight?.call();
      } else {
        widget.onSwipeLeft?.call();
      }

      _swipeCompleted = true;
    });
  }

  /// Handles external controller events for programmatic swiping.
  void _onChangeImageController() {
    final ImageCardEvent? event = widget.controller?.value;

    if (event == null) return;

    _triggerSwipe(isSwipeRight: event == ImageCardEvent.swipeRight);
  }

  @override
  Widget build(BuildContext context) {
    if (_swipeCompleted) {
      return const SizedBox.shrink();
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Offset cardPosition = _animationController.isAnimating
        ? _animation?.value ?? Offset.zero
        : _dragOffset;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double rotationAngle = (cardPosition.dx / screenWidth) * 0.2;
    final bool isSwipingRight = cardPosition.dx > screenWidth * 0.1;
    final bool isSwipingLeft = cardPosition.dx < -screenWidth * 0.1;

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: cardPosition,
        child: Transform.rotate(
          angle: rotationAngle,
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(
                AppConstants.mediumBorderRadius,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(
              horizontal: AppConstants.mediumPadding,
              vertical: AppConstants.largePadding,
            ),
            child: SizedBox(
              height: AppConstants.cardHeight,
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 24,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.contain,
                        placeholder: (BuildContext context, String url) =>
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    context.locale.imageCardLoading,
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        errorWidget:
                            (BuildContext context, String url, Object error) =>
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.error_outline,
                                      color: colorScheme.error,
                                      size: 48,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      context.locale.imageCardError,
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.title != null)
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Text(
                        widget.title ?? '',
                        style: textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  if (isSwipingRight)
                    Positioned(
                      top: 40,
                      left: 20,
                      child: Transform.rotate(
                        angle: -0.5,
                        child: _Stamp(
                          text: context.locale.imageCardLike,
                          color: Colors.green,
                          animationController: _animationController,
                          animationOffset: _animation?.value ?? Offset.zero,
                          dragOffset: _dragOffset,
                        ),
                      ),
                    ),
                  if (isSwipingLeft)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Transform.rotate(
                        angle: 0.5,
                        child: _Stamp(
                          text: context.locale.imageCardOther,
                          color: Colors.red,
                          animationController: _animationController,
                          animationOffset: _animation?.value ?? Offset.zero,
                          dragOffset: _dragOffset,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A visual stamp overlay that appears during swipe gestures.
///
/// This widget displays "LIKE" or "PASS" text with a colored border
/// when the user is actively swiping the card in either direction.
/// The stamp rotates slightly based on the card's rotation angle.
class _Stamp extends StatelessWidget {
  /// Creates a [_Stamp] widget.
  ///
  /// All parameters are required for proper animation synchronization.
  const _Stamp({
    required this.text,
    required this.color,
    required this.animationController,
    required this.animationOffset,
    required this.dragOffset,
  });

  /// The text to display in the stamp (e.g., "LIKE", "PASS").
  final String text;

  /// The color of the stamp border and text.
  final Color color;

  /// Animation controller from the parent [ImageCard].
  final AnimationController animationController;

  /// Current animation offset for position calculation.
  final Offset animationOffset;

  /// Current drag offset for position calculation.
  final Offset dragOffset;

  @override
  Widget build(BuildContext context) {
    final Offset cardPosition = animationController.isAnimating
        ? animationOffset
        : dragOffset;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double rotationAngle = (cardPosition.dx / screenWidth) * 0.2;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 4),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Transform.rotate(
        angle: rotationAngle,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
