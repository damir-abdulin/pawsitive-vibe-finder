
import '../../models/models.dart';
import '../../models/quiz/quiz.dart';
import '../use_case.dart';

/// {@template get_quiz_question_use_case}
/// A use case for generating a single quiz question from a pre-fetched list.
///
/// This use case takes a correct dog answer and a list of all possible breeds
/// to create a complete quiz question with three random incorrect options.
/// {@endtemplate}
class GetQuizQuestionUseCase
    extends UseCase<(DogModel, List<BreedType>), QuizQuestionModel> {
  /// {@macro get_quiz_question_use_case}
  GetQuizQuestionUseCase();

  @override
  QuizQuestionModel unsafeExecute((DogModel, List<BreedType>) input) {
    final (DogModel correctDog, List<BreedType> allBreeds) = input;
    final BreedType correctAnswer = correctDog.breed;

    // Filter out the correct answer and shuffle the rest.
    final List<BreedType> incorrectOptions = allBreeds
        .where((BreedType breed) => breed != correctAnswer)
        .toList();
    incorrectOptions.shuffle();

    // Select 3 random incorrect answers and create the final options list.
    final List<BreedType> options = <BreedType>[correctAnswer];
    options.addAll(incorrectOptions.take(3));
    options.shuffle();

    // Create and return the quiz question model.
    return QuizQuestionModel(
      imageUrl: correctDog.imageUrl,
      correctAnswer: correctAnswer,
      options: options,
    );
  }
}
