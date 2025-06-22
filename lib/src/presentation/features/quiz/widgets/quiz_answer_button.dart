import 'package:flutter/material.dart';

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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
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
              color: _getBackgroundColor(colorScheme),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _getBorderColor(colorScheme),
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
                      color: _getTextColor(colorScheme),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                // Status indicator
                _buildStatusIndicator(colorScheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(ColorScheme colorScheme) {
    if (!isAnswered) {
      return colorScheme.surface;
    }
    if (isCorrect) {
      return colorScheme.secondaryContainer;
    }
    if (isSelected && !isCorrect) {
      return colorScheme.errorContainer;
    }
    return colorScheme.surface;
  }

  Color _getBorderColor(ColorScheme colorScheme) {
    if (!isAnswered) {
      if (isSelected) {
        return colorScheme.primary;
      }
      return colorScheme.outline.withOpacity(0.3);
    }
    if (isCorrect) {
      return colorScheme.secondaryContainer;
    }
    if (isSelected && !isCorrect) {
      return colorScheme.errorContainer;
    }
    return colorScheme.outline.withOpacity(0.3);
  }

  Color _getTextColor(ColorScheme colorScheme) {
    if (!isAnswered) {
      return colorScheme.onSurface;
    }
    if (isCorrect) {
      return colorScheme.secondary;
    }
    if (isSelected && !isCorrect) {
      return colorScheme.error;
    }
    return colorScheme.onSurface;
  }

  Widget _buildStatusIndicator(ColorScheme colorScheme) {
    if (!isAnswered) {
      // Show empty circle for unselected, ring for selected
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.3),
            width: 2,
          ),
        ),
      );
    }

    // Show feedback icons for answered state
    if (isCorrect) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.secondary,
        ),
        child: Icon(Icons.check, color: colorScheme.onSecondary, size: 16),
      );
    }

    if (isSelected && !isCorrect) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.error,
        ),
        child: Icon(Icons.close, color: colorScheme.onError, size: 16),
      );
    }

    // For non-selected incorrect answers, show empty circle
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.3),
          width: 2,
        ),
      ),
    );
  }
}
