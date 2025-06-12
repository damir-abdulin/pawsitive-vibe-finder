import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Footer widget for the quiz with the "Next Question" button.
class QuizFooter extends StatelessWidget {
  /// Creates a [QuizFooter].
  const QuizFooter({
    required this.onNextQuestion,
    required this.isAnswered,
    super.key,
  });

  /// Callback when the "Next Question" button is tapped.
  final VoidCallback onNextQuestion;

  /// Whether an answer has been selected.
  final bool isAnswered;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryBackground,
        border: Border(top: BorderSide(color: Color(0xFFE7D0D1), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: isAnswered ? onNextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
                disabledForegroundColor: AppColors.white.withOpacity(0.7),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Next Question',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.015,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
