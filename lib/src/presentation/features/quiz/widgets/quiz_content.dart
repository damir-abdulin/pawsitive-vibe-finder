import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/breed_type.dart';
import '../../../../domain/models/quiz/quiz_question_model.dart';
import '../../../theme/app_constants.dart';
import '../../../utils/breed_type_localization.dart';
import '../bloc/quiz_bloc.dart';
import 'widgets.dart';

/// Widget that displays the main quiz content based on the current state.
class QuizContent extends StatelessWidget {
  /// Creates a [QuizContent].
  const QuizContent({required this.state, required this.onRetry, super.key});

  /// The current quiz state.
  final QuizState state;

  /// Callback for retrying when an error occurs.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case QuizStatus.loading:
      case QuizStatus.initial:
        return const QuizLoading();
      case QuizStatus.error:
        return QuizErrorState(
          errorMessage: state.errorMessage,
          onRetry: onRetry,
        );
      case QuizStatus.loaded:
      case QuizStatus.answered:
        return QuizContentLoaded(state: state);
      case QuizStatus.complete:
        // This should be handled by the listener, but just in case
        return const Center(child: Text('Quiz completed!'));
    }
  }
}

/// Widget that displays the loaded quiz content with questions and answers.
class QuizContentLoaded extends StatelessWidget {
  /// Creates a [QuizContentLoaded].
  const QuizContentLoaded({required this.state, super.key});

  /// The current quiz state.
  final QuizState state;

  void _onAnswerSelected(BuildContext context, BreedType selectedAnswer) {
    context.read<QuizBloc>().add(
      QuizAnswerSelected(selectedAnswer: selectedAnswer),
    );
  }

  @override
  Widget build(BuildContext context) {
    final QuizQuestionModel? question = state.question;
    if (question == null) {
      return const QuizLoading();
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Dog image
          const SizedBox(height: AppConstants.mediumPadding),
          QuizImage(imageUrl: question.imageUrl),
          const SizedBox(height: AppConstants.mediumPadding),
          // Score and question number
          QuizScoreDisplay(
            score: state.score,
            questionNumber: state.questionNumber,
            totalQuestions: AppConstants.totalQuizQuestions,
          ),
          const SizedBox(height: AppConstants.smallPadding),
          // Answer options
          ...question.options.map((BreedType breed) {
            final bool isSelected = state.selectedAnswer == breed;
            final bool isCorrect = question.correctAnswer == breed;
            final bool isAnswered = state.status == QuizStatus.answered;

            return QuizAnswerButton(
              text: breed.toLocal(context),
              onPressed: isAnswered
                  ? null
                  : () => _onAnswerSelected(context, breed),
              isCorrect: isCorrect,
              isSelected: isSelected,
              isAnswered: isAnswered,
            );
          }),
          const SizedBox(height: AppConstants.mediumPadding),
        ],
      ),
    );
  }
}
