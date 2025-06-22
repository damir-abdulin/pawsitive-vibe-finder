import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';
import '../../../widgets/image_card/image_card_controller.dart';

/// Animated home image card widget for swipeable interaction.
class HomeAnimatedCard extends StatefulWidget {
  /// Creates a [HomeAnimatedCard].
  const HomeAnimatedCard({
    required this.dog,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.controller,
    super.key,
  });

  /// The dog to display.
  final DogModel dog;

  /// Callback when the card is swiped left.
  final VoidCallback onSwipeLeft;

  /// Callback when the card is swiped right.
  final VoidCallback onSwipeRight;

  /// Optional controller for programmatic swipes.
  final ImageCardController? controller;

  @override
  State<HomeAnimatedCard> createState() => _HomeAnimatedCardState();
}

class _HomeAnimatedCardState extends State<HomeAnimatedCard>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<Offset>? _animation;
  Offset _dragOffset = Offset.zero;
  bool _swipeCompleted = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    widget.controller?.addListener(_onChangeImageController);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onChangeImageController);
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(HomeAnimatedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_onChangeImageController);
      widget.controller?.addListener(_onChangeImageController);
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_animationController.isAnimating || _swipeCompleted) return;
    setState(() {
      _dragOffset += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_animationController.isAnimating || _swipeCompleted) return;

    const double swipeThreshold = 100.0;
    const double velocityThreshold = 500.0;

    final double dragDistance = _dragOffset.dx.abs();
    final double velocity = details.velocity.pixelsPerSecond.dx.abs();

    if (dragDistance > swipeThreshold || velocity > velocityThreshold) {
      _triggerSwipe(isSwipeRight: _dragOffset.dx > 0);
    } else {
      // Return to center
      setState(() {
        _dragOffset = Offset.zero;
      });
    }
  }

  void _triggerSwipe({required bool isSwipeRight}) {
    if (_swipeCompleted) return;

    final double screenWidth = MediaQuery.of(context).size.width;
    final Offset begin = _dragOffset;
    final Offset end = isSwipeRight
        ? Offset(screenWidth + 100, _dragOffset.dy + 50)
        : Offset(-screenWidth - 100, _dragOffset.dy - 50);

    _animation = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward().whenComplete(() {
      if (isSwipeRight) {
        widget.onSwipeRight();
      } else {
        widget.onSwipeLeft();
      }
      _swipeCompleted = true;
    });
  }

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

    final Offset cardPosition = _animationController.isAnimating
        ? _animation?.value ?? Offset.zero
        : _dragOffset;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double rotationAngle = (cardPosition.dx / screenWidth) * 0.15;
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
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            child: AspectRatio(
              aspectRatio: 3 / 4, // 3:4 aspect ratio from design
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: <Widget>[
                    // Dog image with improved caching
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: widget.dog.imageUrl,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 150),
                        fadeOutDuration: const Duration(milliseconds: 100),
                        memCacheWidth: 400, // Optimize memory usage
                        memCacheHeight: 533, // 400 * 4/3 for aspect ratio
                        placeholder: (BuildContext context, String url) =>
                            Container(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceContainerHighest,
                              child: Center(
                                child: SizedBox(
                                  width: 32,
                                  height: 32,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        errorWidget:
                            (BuildContext context, String url, Object error) =>
                                Container(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.pets,
                                          size: 48,
                                          color: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Image unavailable',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                      ),
                    ),
                    // Swipe right stamp (LIKE)
                    if (isSwipingRight)
                      Positioned(
                        top: 40,
                        left: 20,
                        child: Transform.rotate(
                          angle: -0.3,
                          child: _SwipeStamp(
                            text: 'LIKE',
                            color: Colors.green,
                            cardPosition: cardPosition,
                            screenWidth: screenWidth,
                          ),
                        ),
                      ),
                    // Swipe left stamp (NOPE)
                    if (isSwipingLeft)
                      Positioned(
                        top: 40,
                        right: 20,
                        child: Transform.rotate(
                          angle: 0.3,
                          child: _SwipeStamp(
                            text: 'NOPE',
                            color: Colors.red,
                            cardPosition: cardPosition,
                            screenWidth: screenWidth,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwipeStamp extends StatelessWidget {
  const _SwipeStamp({
    required this.text,
    required this.color,
    required this.cardPosition,
    required this.screenWidth,
  });

  final String text;
  final Color color;
  final Offset cardPosition;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    final double opacity = (cardPosition.dx.abs() / (screenWidth * 0.3)).clamp(
      0.0,
      1.0,
    );

    return Opacity(
      opacity: opacity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
          borderRadius: BorderRadius.circular(8),
          color: color.withValues(alpha: 0.1),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
