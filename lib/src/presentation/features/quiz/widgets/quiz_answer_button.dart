import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Answer option button for the quiz with different visual states.
class QuizAnswerButton extends StatelessWidget {
  /// Creates a [QuizAnswerButton].
  const QuizAnswerButton({
    required this.text,
    required this.onPressed,
    required this.isCorrect,
    required this.isSelected,
    required this.isAnswered,
    super.key,
  });

  /// The text to display on the button.
  final String text;

  /// The callback to execute when the button is pressed.
  /// If null, the button is disabled.
  final VoidCallback? onPressed;

  /// Whether this button represents the correct answer.
  final bool isCorrect;

  /// Whether this button was the one selected by the user.
  final bool isSelected;

  /// Whether any answer has been selected for the current question.
  final bool isAnswered;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getBackgroundColor(),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getBorderColor(),
                width: isSelected && !isAnswered ? 2 : 1,
              ),
            ),
            child: Row(
              children: <Widget>[
                // Answer text
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: _getTextColor(),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Status indicator
                _buildStatusIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (!isAnswered) {
      return AppColors.white;
    }
    if (isCorrect) {
      return const Color(0xFFD1FAE5); // Correct answer background
    }
    if (isSelected && !isCorrect) {
      return const Color(0xFFFEE2E2); // Incorrect answer background
    }
    return AppColors.white;
  }

  Color _getBorderColor() {
    if (!isAnswered) {
      if (isSelected) {
        return AppColors.primary;
      }
      return const Color(0xFFE7D0D1); // Default border color
    }
    if (isCorrect) {
      return const Color(0xFFD1FAE5); // Correct answer border
    }
    if (isSelected && !isCorrect) {
      return const Color(0xFFFEE2E2); // Incorrect answer border
    }
    return const Color(0xFFE7D0D1);
  }

  Color _getTextColor() {
    if (!isAnswered) {
      return AppColors.textPrimary;
    }
    if (isCorrect) {
      return const Color(0xFF065F46); // Correct answer text
    }
    if (isSelected && !isCorrect) {
      return const Color(0xFF991B1B); // Incorrect answer text
    }
    return AppColors.textPrimary;
  }

  Widget _buildStatusIndicator() {
    if (!isAnswered) {
      // Show empty circle for unselected, ring for selected
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE7D0D1), width: 2),
        ),
      );
    }

    // Show feedback icons for answered state
    if (isCorrect) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF065F46), // Correct answer icon background
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      );
    }

    if (isSelected && !isCorrect) {
      return Container(
        width: 24,
        height: 24,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF991B1B), // Incorrect answer icon background
        ),
        child: const Icon(Icons.close, color: Colors.white, size: 16),
      );
    }

    // For non-selected incorrect answers, show empty circle
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE7D0D1), width: 2),
      ),
    );
  }
}
