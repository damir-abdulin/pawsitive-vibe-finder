import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../../domain/domain.dart';

import 'bloc/quiz_bloc.dart';
import 'quiz_body.dart';

@RoutePage()
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
      create: (BuildContext context) => QuizBloc(
        getQuizQuestionUseCase: appLocator<GetQuizQuestionUseCase>(),
        getRandomDogsUseCase: appLocator<GetRandomDogsUseCase>(),
        getBreedsUseCase: appLocator<GetBreedsUseCase>(),
      )..add(QuizStarted()),
      child: const QuizBody(),
    );
  }
}
