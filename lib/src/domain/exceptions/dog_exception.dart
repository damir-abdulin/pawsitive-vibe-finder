import 'app_exception.dart';

/// An exception for errors related to dog data operations.
class DogException extends AppException {
  /// Creates a [DogException].
  const DogException(super.message);
}
