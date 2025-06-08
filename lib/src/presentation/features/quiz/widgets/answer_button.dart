import 'package:flutter/material.dart';

/// A custom button for displaying a quiz answer option.
///
/// The button's appearance changes based on whether it has been
/// answered, and if so, whether it was the correct or incorrect choice.
class AnswerButton extends StatelessWidget {
  /// Creates an [AnswerButton].
  const AnswerButton({
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
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(_getBackgroundColor(context)),
        foregroundColor: WidgetStateProperty.all(_getForegroundColor(context)),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(child: Text(text, textAlign: TextAlign.center)),
          _IconWidget(
            isCorrect: isCorrect,
            isSelected: isSelected,
            isAnswered: isAnswered,
          ),
        ],
      ),
    );
  }

  Color? _getBackgroundColor(BuildContext context) {
    if (!isAnswered) {
      return Theme.of(context).colorScheme.secondaryContainer;
    }
    if (isCorrect) {
      return Colors.green;
    }
    if (isSelected) {
      return Colors.red;
    }
    return Theme.of(
      context,
    ).colorScheme.secondaryContainer.withValues(alpha: 0.5);
  }

  Color? _getForegroundColor(BuildContext context) {
    if (!isAnswered) {
      return Theme.of(context).colorScheme.onSecondaryContainer;
    }
    if (isCorrect || isSelected) {
      return Colors.white;
    }
    return Theme.of(
      context,
    ).colorScheme.onSecondaryContainer.withValues(alpha: 0.5);
  }
}

class _IconWidget extends StatelessWidget {
  const _IconWidget({
    required this.isCorrect,
    required this.isSelected,
    required this.isAnswered,
  });

  final bool isCorrect;
  final bool isSelected;
  final bool isAnswered;

  @override
  Widget build(BuildContext context) {
    if (!isAnswered) {
      return const SizedBox(width: 24);
    }
    if (isCorrect) {
      return const Icon(Icons.check_circle, color: Colors.white);
    }
    if (isSelected) {
      return const Icon(Icons.cancel, color: Colors.white);
    }
    return const SizedBox(width: 24);
  }
}
