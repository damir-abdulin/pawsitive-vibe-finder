import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../domain/domain.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

/// The total number of questions in a single quiz session.
const int totalQuestions = 10;

/// {@template quiz_bloc}
/// Manages the state for the "Guess the Breed" quiz feature.
/// {@endtemplate}
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  /// {@macro quiz_bloc}
  QuizBloc({
    required GetQuizQuestionUseCase getQuizQuestionUseCase,
    required GetRandomDogsUseCase getRandomDogsUseCase,
    required GetBreedsUseCase getBreedsUseCase,
  }) : _getQuizQuestionUseCase = getQuizQuestionUseCase,
       _getRandomDogsUseCase = getRandomDogsUseCase,
       _getBreedsUseCase = getBreedsUseCase,
       super(const QuizState.initial()) {
    on<QuizStarted>(_onQuizStarted);
    on<QuizAnswerSelected>(_onQuizAnswerSelected);
    on<QuizNextQuestion>(_onQuizNextQuestion);
  }

  final GetQuizQuestionUseCase _getQuizQuestionUseCase;
  final GetRandomDogsUseCase _getRandomDogsUseCase;
  final GetBreedsUseCase _getBreedsUseCase;

  Future<void> _onQuizStarted(
    QuizStarted event,
    Emitter<QuizState> emit,
  ) async {
    emit(state.copyWith(status: QuizStatus.loading));
    try {
      // Fetch all data needed for the quiz at the start.
      final List<DogModel> questions = await _getRandomDogsUseCase.execute((
        totalQuestions,
        null,
      ));
      final List<BreedType> allBreeds = await _getBreedsUseCase.execute(null);

      if (questions.length < totalQuestions) {
        throw Exception('Could not load enough questions for the quiz.');
      }

      emit(
        state.copyWith(
          questions: questions,
          allBreeds: allBreeds,
          status: QuizStatus.loaded,
        ),
      );
      _prepareQuestion(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: QuizStatus.error,
          errorMessage: 'Failed to start the quiz. Please try again.',
        ),
      );
    }
  }

  Future<void> _onQuizAnswerSelected(
    QuizAnswerSelected event,
    Emitter<QuizState> emit,
  ) async {
    final bool isCorrect =
        event.selectedAnswer == state.question!.correctAnswer;
    emit(
      state.copyWith(
        status: QuizStatus.answered,
        selectedAnswer: event.selectedAnswer,
        score: isCorrect ? state.score + 1 : state.score,
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 1500));
    add(QuizNextQuestion());
  }

  Future<void> _onQuizNextQuestion(
    QuizNextQuestion event,
    Emitter<QuizState> emit,
  ) async {
    if (state.questionNumber >= totalQuestions) {
      emit(state.copyWith(status: QuizStatus.complete));
    } else {
      // All data is pre-loaded, just need to prepare the next question.
      _prepareQuestion(emit);
    }
  }

  void _prepareQuestion(Emitter<QuizState> emit) {
    // Get the next dog from the pre-fetched list.
    final DogModel correctDog = state.questions[state.questionNumber];

    final QuizQuestionModel question = _getQuizQuestionUseCase.execute((
      correctDog,
      state.allBreeds,
    ));

    emit(
      state.copyWith(
        status: QuizStatus.loaded,
        question: question,
        questionNumber: state.questionNumber + 1,
      ),
    );
  }
}
