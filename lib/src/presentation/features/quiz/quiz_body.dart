import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigation/app_router.dart';
import '../../theme/app_constants.dart';
import 'bloc/quiz_bloc.dart';
import 'widgets/widgets.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({super.key});

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<QuizBloc, QuizState>(
        listener: (BuildContext context, QuizState state) {
          if (state.status == QuizStatus.complete) {
            context.router.replace(
              QuizScoreRoute(
                score: state.score,
                totalQuestions: AppConstants.totalQuizQuestions,
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
              Expanded(
                child: QuizContent(state: state, onRetry: _onRetry),
              ),
            ],
          );
        },
      ),
    );
  }
}
