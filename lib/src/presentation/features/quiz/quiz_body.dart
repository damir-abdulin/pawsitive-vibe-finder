import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/breed_type.dart';
import '../../../domain/models/quiz/quiz_question_model.dart';
import '../../navigation/app_router.dart';
import '../../utils/breed_type_localization.dart';
import 'bloc/quiz_bloc.dart';
import 'widgets/answer_button.dart';

class QuizBody extends StatelessWidget {
  const QuizBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guess the Breed')),
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (BuildContext context, QuizState state) {
          if (state.status == QuizStatus.complete) {
            context.router.replace(
              QuizScoreRoute(score: state.score, totalQuestions: 10),
            );
          }
        },
        builder: (BuildContext context, QuizState state) {
          if (state.status == QuizStatus.loading && state.question == null) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == QuizStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(state.errorMessage ?? 'An unknown error occurred.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<QuizBloc>().add(QuizStarted()),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          if (state.question == null) {
            return const Center(child: Text('No question loaded.'));
          }

          final QuizQuestionModel question = state.question!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Score: ${state.score}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      '${state.questionNumber} / 10',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: question.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (_, __, ___) =>
                          const Center(child: Icon(Icons.error, size: 40)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ...question.options.map((BreedType breed) {
                  final bool isSelected = state.selectedAnswer == breed;
                  final bool isCorrect = question.correctAnswer == breed;
                  final bool isAnswered = state.status == QuizStatus.answered;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: AnswerButton(
                      text: breed.toLocal(context),
                      onPressed: isAnswered
                          ? null
                          : () {
                              context.read<QuizBloc>().add(
                                QuizAnswerSelected(selectedAnswer: breed),
                              );
                            },
                      isCorrect: isCorrect,
                      isSelected: isSelected,
                      isAnswered: isAnswered,
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
