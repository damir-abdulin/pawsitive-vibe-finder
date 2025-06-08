import 'app_exception.dart';

/// An exception for errors related to breed data operations.
class BreedException extends AppException {
  /// Creates a [BreedException].
  const BreedException({super.message, super.cause});
}
