import 'package:flutter/material.dart';
import '../../../../domain/domain.dart';
import '../../../theme/colors.dart';
import '../../../utils/breed_type_localization.dart';

/// Home breed info widget that displays breed name and instructions with animation.
class HomeBreedInfo extends StatefulWidget {
  /// Creates a [HomeBreedInfo].
  const HomeBreedInfo({required this.dog, super.key});

  /// The dog to display information for.
  final DogModel dog;

  @override
  State<HomeBreedInfo> createState() => _HomeBreedInfoState();
}

class _HomeBreedInfoState extends State<HomeBreedInfo>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void didUpdateWidget(HomeBreedInfo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dog.imageUrl != oldWidget.dog.imageUrl) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _fadeAnimation,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
            child: Column(
              children: <Widget>[
                // Breed name
                Text(
                  widget.dog.breed.toLocal(context),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                // Instructions text
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Swipe left to discover, swipe right to like!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
