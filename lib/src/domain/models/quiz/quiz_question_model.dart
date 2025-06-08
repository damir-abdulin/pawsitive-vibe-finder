import 'package:equatable/equatable.dart';

import '../breed_type.dart';

/// {@template quiz_question_model}
/// A model representing a single quiz question.
///
/// Contains the image to display and the possible answers.
/// {@endtemplate}
class QuizQuestionModel extends Equatable {
  /// {@macro quiz_question_model}
  const QuizQuestionModel({
    required this.imageUrl,
    required this.options,
    required this.correctAnswer,
  });

  /// The URL of the dog image for the question.
  final String imageUrl;

  /// A list of 4 breed options for the user to choose from.
  final List<BreedType> options;

  /// The correct breed for the image.
  final BreedType correctAnswer;

  @override
  List<Object> get props => <Object>[imageUrl, options, correctAnswer];
}
