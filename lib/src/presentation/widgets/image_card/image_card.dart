import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../localization/locale_extension.dart';
import 'image_card_controller.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({
    required this.imageUrl,
    this.controller,
    this.title,
    this.duration = const Duration(milliseconds: 300),
    this.dragBorder = 300,
    this.onSwipeRight,
    this.onSwipeLeft,
    super.key,
  });

  final String imageUrl;
  final String? title;
  final ImageCardController? controller;

  final Duration duration;
  final double dragBorder;

  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeLeft;

  @override
  State<ImageCard> createState() => ImageCardState();
}

class ImageCardState extends State<ImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<Offset>? _animation;
  Offset _dragOffset = Offset.zero;

  bool _swipeCompleted = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
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

  void _onPanUpdate(DragUpdateDetails details) {
    if (_animationController.isAnimating) return;
    setState(() {
      _dragOffset = Offset(_dragOffset.dx + details.delta.dx, 0);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final Offset dragVector = details.velocity.pixelsPerSecond;

    if (dragVector.dx.abs() > 300) {
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
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              height: 500,
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
                                children: [
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
                                  children: [
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

class _Stamp extends StatelessWidget {
  const _Stamp({
    required this.text,
    required this.color,
    required this.animationController,
    required this.animationOffset,
    required this.dragOffset,
  });

  final String text;
  final Color color;

  final AnimationController animationController;
  final Offset animationOffset;
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
