part of 'quiz_bloc.dart';

/// Base class for all events related to the quiz feature.
@immutable
abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Event triggered when the quiz is first started.
class QuizStarted extends QuizEvent {}

/// Event triggered when the user selects an answer for the current question.
class QuizAnswerSelected extends QuizEvent {
  /// The breed selected by the user.
  final BreedType selectedAnswer;

  /// Creates a [QuizAnswerSelected] event.
  const QuizAnswerSelected({required this.selectedAnswer});

  @override
  List<Object?> get props => <Object?>[selectedAnswer];
}

/// Event triggered to move to the next question after an answer is shown.
class QuizNextQuestion extends QuizEvent {}
