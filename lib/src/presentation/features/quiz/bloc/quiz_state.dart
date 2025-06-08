part of 'quiz_bloc.dart';

/// The status of the quiz.
enum QuizStatus {
  /// The quiz is in its initial state, before starting.
  initial,

  /// The quiz is loading a new question.
  loading,

  /// The quiz has loaded a question and is awaiting a user answer.
  loaded,

  /// The user has selected an answer and is seeing feedback.
  answered,

  /// The quiz has been completed.
  complete,

  /// An error has occurred.
  error,
}

/// {@template quiz_state}
/// The state of the quiz feature.
/// {@endtemplate}
class QuizState extends Equatable {
  /// {@macro quiz_state}
  const QuizState({
    this.status = QuizStatus.initial,
    this.questions = const <DogModel>[],
    this.allBreeds = const <BreedType>[],
    this.question,
    this.selectedAnswer,
    this.score = 0,
    this.questionNumber = 0,
    this.errorMessage,
  });

  /// The current status of the quiz.
  final QuizStatus status;

  /// The list of all dog models for the quiz session.
  final List<DogModel> questions;

  /// The cached list of all available breeds.
  final List<BreedType> allBreeds;

  /// The current quiz question.
  final QuizQuestionModel? question;

  /// The answer selected by the user.
  final BreedType? selectedAnswer;

  /// The user's current score.
  final int score;

  /// The current question number (1-based).
  final int questionNumber;

  /// The error message, if any.
  final String? errorMessage;

  /// Creates an initial state for the quiz.
  const QuizState.initial() : this();

  /// Creates a copy of the current state with updated values.
  QuizState copyWith({
    QuizStatus? status,
    List<DogModel>? questions,
    List<BreedType>? allBreeds,
    QuizQuestionModel? question,
    BreedType? selectedAnswer,
    int? score,
    int? questionNumber,
    String? errorMessage,
  }) {
    return QuizState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      allBreeds: allBreeds ?? this.allBreeds,
      question: question ?? this.question,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      score: score ?? this.score,
      questionNumber: questionNumber ?? this.questionNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    status,
    questions,
    allBreeds,
    question,
    selectedAnswer,
    score,
    questionNumber,
    errorMessage,
  ];
}
