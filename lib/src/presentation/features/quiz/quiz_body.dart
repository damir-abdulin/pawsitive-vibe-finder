import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/breed_type.dart';
import '../../../domain/models/quiz/quiz_question_model.dart';
import '../../navigation/app_router.dart';
import '../../utils/breed_type_localization.dart';
import 'bloc/quiz_bloc.dart';
import 'widgets/widgets.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({super.key});

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  static const int totalQuestions = 10;

  void _onAnswerSelected(BreedType selectedAnswer) {
    context.read<QuizBloc>().add(
      QuizAnswerSelected(selectedAnswer: selectedAnswer),
    );
  }

  void _onNextQuestion() {
    final QuizBloc bloc = context.read<QuizBloc>();
    final QuizState state = bloc.state;

    if (state.questionNumber < totalQuestions) {
      bloc.add(QuizNextQuestion());
    } else {
      context.router.replace(
        QuizScoreRoute(score: state.score, totalQuestions: totalQuestions),
      );
    }
  }

  void _onClose() {
    QuizExitConfirmationSheet.show(
      context,
      onConfirmExit: () {
        Navigator.of(context).pop(); // Close the bottom sheet
        context.router.maybePop(); // Exit the quiz
      },
      onContinueQuiz: () {
        Navigator.of(context).pop(); // Close the bottom sheet and continue quiz
      },
    );
  }

  void _onRetry() {
    context.read<QuizBloc>().add(QuizStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8F8), // Background color from design
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (BuildContext context, QuizState state) {
          if (state.status == QuizStatus.complete) {
            context.router.replace(
              QuizScoreRoute(
                score: state.score,
                totalQuestions: totalQuestions,
              ),
            );
          }
        },
        builder: (BuildContext context, QuizState state) {
          return Column(
            children: <Widget>[
              // Sticky header
              QuizHeader(onClose: _onClose),
              // Main content
              Expanded(child: _buildContent(state)),
              // Sticky footer (only show when question is loaded and not complete)
              if (state.status == QuizStatus.loaded ||
                  state.status == QuizStatus.answered)
                QuizFooter(
                  onNextQuestion: _onNextQuestion,
                  isAnswered: state.status == QuizStatus.answered,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(QuizState state) {
    switch (state.status) {
      case QuizStatus.loading:
      case QuizStatus.initial:
        return const QuizLoading();
      case QuizStatus.error:
        return QuizErrorState(
          errorMessage: state.errorMessage,
          onRetry: _onRetry,
        );
      case QuizStatus.loaded:
      case QuizStatus.answered:
        return _buildQuizContent(state);
      case QuizStatus.complete:
        // This should be handled by the listener, but just in case
        return const Center(child: Text('Quiz completed!'));
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildQuizContent(QuizState state) {
    final QuizQuestionModel? question = state.question;
    if (question == null) {
      return const QuizLoading();
    }

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Dog image
          const SizedBox(height: 16),
          QuizImage(imageUrl: question.imageUrl),
          const SizedBox(height: 16),
          // Score and question number
          QuizScoreDisplay(
            score: state.score,
            questionNumber: state.questionNumber,
            totalQuestions: totalQuestions,
          ),
          const SizedBox(height: 8),
          // Answer options
          ...question.options.map((BreedType breed) {
            final bool isSelected = state.selectedAnswer == breed;
            final bool isCorrect = question.correctAnswer == breed;
            final bool isAnswered = state.status == QuizStatus.answered;

            return QuizAnswerButton(
              text: breed.toLocal(context),
              onPressed: isAnswered ? null : () => _onAnswerSelected(breed),
              isCorrect: isCorrect,
              isSelected: isSelected,
              isAnswered: isAnswered,
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
