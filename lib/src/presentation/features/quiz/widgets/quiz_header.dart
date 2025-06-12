import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Header widget for the quiz screen with close button and title.
class QuizHeader extends StatelessWidget {
  /// Creates a [QuizHeader].
  const QuizHeader({required this.onClose, super.key});

  /// Callback when the close button is tapped.
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBackground,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.primaryBackground,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: <Widget>[
              // Close button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onClose,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                  ),
                ),
              ),
              // Centered title
              Expanded(
                child: Text(
                  'Guess the Breed',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.015,
                  ),
                ),
              ),
              // Placeholder for balance (same width as close button)
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }
}
