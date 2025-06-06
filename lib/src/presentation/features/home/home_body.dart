import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawsitive_vibe_finder/src/domain/domain.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/home/bloc/home_bloc.dart';
import 'package:pawsitive_vibe_finder/src/presentation/localization/locale_extension.dart';

class HomeBody extends StatelessWidget {
  HomeBody({super.key});

  final GlobalKey<_DogImageCardState> _cardKey =
      GlobalKey<_DogImageCardState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is FirstLaunchState) {
          _showWelcomeDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.locale.appTitle)),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final textTheme = Theme.of(context).textTheme;
            final colorScheme = Theme.of(context).colorScheme;

            if (state is HomeLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.primary,
                  ),
                ),
              );
            }
            if (state is SubsequentLaunchState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: _DogImageCard(key: _cardKey, state: state),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          context: context,
                          icon: Icons.close,
                          color: Colors.red,
                          onPressed: () => _cardKey.currentState?.triggerSwipe(
                            isSwipeRight: false,
                          ),
                        ),
                        _buildActionButton(
                          context: context,
                          icon: Icons.favorite,
                          color: Colors.green,
                          onPressed: () => _cardKey.currentState?.triggerSwipe(
                            isSwipeRight: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            if (state is HomeError) {
              return Center(
                child: Text(
                  state.message,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.error,
                  ),
                ),
              );
            }
            // This covers HomeInitial and the base view for FirstLaunchState
            return Center(
              child: Text(
                context.locale.homeWelcome,
                style: textTheme.headlineMedium,
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showWelcomeDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(context.locale.homeWelcome),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[Text(context.locale.appTitle)]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Get Started'), // This should also be localized
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<HomeBloc>().add(CompleteFirstLaunchEvent());
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        side: BorderSide(color: color, width: 2),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }
}

class _DogImageCard extends StatefulWidget {
  const _DogImageCard({super.key, required this.state});

  final SubsequentLaunchState state;

  @override
  State<_DogImageCard> createState() => _DogImageCardState();
}

class _DogImageCardState extends State<_DogImageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  Offset _dragOffset = Offset.zero;

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
  }

  @override
  void didUpdateWidget(covariant _DogImageCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state.imageUrl != oldWidget.state.imageUrl) {
      _animationController.reset();
      _dragOffset = Offset.zero;
    }
  }

  @override
  void dispose() {
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
    final dragVector = details.velocity.pixelsPerSecond;
    final screenWidth = MediaQuery.of(context).size.width;

    if (dragVector.dx.abs() > 300) {
      // Start animation only if swipe is fast enough
      final isSwipeRight = dragVector.dx > 0;
      final targetX = isSwipeRight ? screenWidth * 1.5 : -screenWidth * 1.5;

      _animation =
          Tween<Offset>(
            begin: _dragOffset,
            end: Offset(targetX, _dragOffset.dy),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
          );

      _animationController.forward().whenComplete(() {
        final dog = RandomDogModel(
          imageUrl: widget.state.imageUrl,
          breed: widget.state.breed,
        );
        if (isSwipeRight) {
          context.read<HomeBloc>().add(SwipeRightEvent(dog: dog));
        } else {
          context.read<HomeBloc>().add(SwipeLeftEvent());
        }
      });
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

  void triggerSwipe({required bool isSwipeRight}) {
    if (_animationController.isAnimating) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final targetX = isSwipeRight ? screenWidth * 1.5 : -screenWidth * 1.5;

    _animation = Tween<Offset>(begin: Offset.zero, end: Offset(targetX, 0))
        .animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward().whenComplete(() {
      final dog = RandomDogModel(
        imageUrl: widget.state.imageUrl,
        breed: widget.state.breed,
      );
      if (isSwipeRight) {
        context.read<HomeBloc>().add(SwipeRightEvent(dog: dog));
      } else {
        context.read<HomeBloc>().add(SwipeLeftEvent());
      }
    });
  }

  Widget _buildStamp({required String text, required Color color}) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cardPosition = _animationController.isAnimating
        ? _animation.value
        : _dragOffset;
    final screenWidth = MediaQuery.of(context).size.width;
    final rotationAngle = (cardPosition.dx / screenWidth) * 0.2;
    final isSwipingRight = cardPosition.dx > screenWidth * 0.1;
    final isSwipingLeft = cardPosition.dx < -screenWidth * 0.1;

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final cardPosition = _animationController.isAnimating
        ? _animation.value
        : _dragOffset;
    final screenWidth = MediaQuery.of(context).size.width;
    final rotationAngle = (cardPosition.dx / screenWidth) * 0.2;
    final isSwipingRight = cardPosition.dx > screenWidth * 0.1;
    final isSwipingLeft = cardPosition.dx < -screenWidth * 0.1;

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: cardPosition,
        child: Transform.rotate(
          angle: rotationAngle,
          child: Card(
            color: colorScheme.surface,
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 24,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.state.imageUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              colorScheme.primary,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error_outline,
                          color: colorScheme.error,
                          size: 48,
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
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      widget.state.breed,
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
                        child: _buildStamp(text: 'LIKE', color: Colors.green),
                      ),
                    ),
                  if (isSwipingLeft)
                    Positioned(
                      top: 40,
                      right: 20,
                      child: Transform.rotate(
                        angle: 0.5,
                        child: _buildStamp(text: 'NOPE', color: Colors.red),
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
