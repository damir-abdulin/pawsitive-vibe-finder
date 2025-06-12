import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';
import '../../../widgets/image_card/image_card_controller.dart';
import 'home_animated_card.dart';
import 'home_static_card.dart';

/// A stack of dog image cards showing the current dog and previews of upcoming dogs.
class HomeImageStack extends StatefulWidget {
  /// Creates a [HomeImageStack].
  const HomeImageStack({
    required this.dogs,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    this.controller,
    super.key,
  });

  /// The list of dogs to display in the stack.
  final List<DogModel> dogs;

  /// Callback when the top card is swiped left.
  final VoidCallback onSwipeLeft;

  /// Callback when the top card is swiped right.
  final VoidCallback onSwipeRight;

  /// Optional controller for programmatic swipes.
  final ImageCardController? controller;

  @override
  State<HomeImageStack> createState() => _HomeImageStackState();
}

class _HomeImageStackState extends State<HomeImageStack>
    with TickerProviderStateMixin {
  late AnimationController _stackAnimationController;
  late Animation<double> _stackAnimation;
  String? _lastTopDogUrl;

  @override
  void initState() {
    super.initState();
    _stackAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _stackAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _stackAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _stackAnimationController.value = 1.0; // Start fully visible
    if (widget.dogs.isNotEmpty) {
      _lastTopDogUrl = widget.dogs.first.imageUrl;
    }
  }

  @override
  void didUpdateWidget(HomeImageStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Only animate when the top dog actually changes
    if (widget.dogs.isNotEmpty &&
        _lastTopDogUrl != null &&
        widget.dogs.first.imageUrl != _lastTopDogUrl) {
      _lastTopDogUrl = widget.dogs.first.imageUrl;
      // Smooth transition without reset
      _stackAnimationController.forward(from: 0.8);
    } else if (widget.dogs.isNotEmpty) {
      _lastTopDogUrl = widget.dogs.first.imageUrl;
    }
  }

  @override
  void dispose() {
    _stackAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dogs.isEmpty) {
      return const SizedBox.shrink();
    }

    // Show up to 3 cards in the stack
    final int maxCards = widget.dogs.length > 3 ? 3 : widget.dogs.length;
    final List<DogModel> stackDogs = widget.dogs.take(maxCards).toList();

    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Background cards (always visible, no animation)
          for (int i = maxCards - 1; i > 0; i--)
            _buildBackgroundCard(stackDogs[i], i, maxCards),
          // Top card (with minimal animation)
          AnimatedBuilder(
            animation: _stackAnimation,
            builder: (BuildContext context, Widget? child) {
              return _buildTopCard(stackDogs.first);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCard(DogModel dog, int index, int totalCards) {
    return HomeStaticCard(
      key: ValueKey<String>('${dog.imageUrl}_background_$index'),
      dog: dog,
      isBackground: true,
    );
  }

  Widget _buildTopCard(DogModel dog) {
    // Minimal scale animation only for smooth transitions
    final double scale = 0.95 + (0.05 * _stackAnimation.value);

    return Transform.scale(
      scale: scale,
      child: HomeAnimatedCard(
        key: ValueKey<String>(dog.imageUrl),
        dog: dog,
        controller: widget.controller,
        onSwipeLeft: () {
          widget.onSwipeLeft();
          // No animation reset, let the natural state update handle it
        },
        onSwipeRight: () {
          widget.onSwipeRight();
          // No animation reset, let the natural state update handle it
        },
      ),
    );
  }
}
