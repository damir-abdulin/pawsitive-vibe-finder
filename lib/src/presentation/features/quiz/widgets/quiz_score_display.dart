import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Widget to display the current score and question number in the quiz.
class QuizScoreDisplay extends StatelessWidget {
  /// Creates a [QuizScoreDisplay].
  const QuizScoreDisplay({
    required this.score,
    required this.questionNumber,
    required this.totalQuestions,
    super.key,
  });

  /// The current score.
  final int score;

  /// The current question number (1-based).
  final int questionNumber;

  /// The total number of questions.
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Score display
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                  text: 'Score: ',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: score.toString(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Question number display
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                  text: 'Question ',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: questionNumber.toString(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: '/$totalQuestions',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
