import '../exceptions/app_exception.dart';

/// An abstract class representing a synchronous use case.
///
/// A use case is a single-purpose class that encapsulates a specific piece of
/// business logic. It receives an input [I] and returns an output [O].
///
/// This class provides a structured way to execute business logic, including
/// built-in error handling.
abstract class UseCase<I, O> {
  /// Default constructor for subclasses.
  const UseCase();

  /// The core logic of the use case.
  ///
  /// Subclasses must implement this method to perform the specific business
  /// operation. If a domain-specific error occurs (an instance of [AppException]),
  /// it should be thrown.
  O unsafeExecute(I input);

  /// Executes the use case with error handling.
  ///
  /// This method wraps the call to [unsafeExecute] in a try-catch block.
  /// If an [AppException] is caught, the optional [onError] handler is called.
  /// If no [onError] handler is provided, the exception is re-thrown.
  O execute(I input, {O Function(AppException)? onError}) {
    try {
      return unsafeExecute(input);
    } on AppException catch (ex) {
      if (onError != null) {
        return onError.call(ex);
      } else {
        rethrow;
      }
    }
  }

  /// Executes the use case and returns `null` if an [AppException] occurs.
  ///
  /// This is a convenience method for scenarios where a failure in the use
  /// case can be gracefully ignored without needing specific error handling.
  O? executeOrNull(I input) {
    try {
      return unsafeExecute(input);
    } on AppException {
      return null;
    }
  }
}

/// An abstract class representing an asynchronous use case that returns a [Future].
///
/// This class follows the same structure as [UseCase] but is designed for
/// operations that are asynchronous, such as network requests or database queries.
abstract class FutureUseCase<I, O> {
  /// Default constructor for subclasses.
  const FutureUseCase();

  /// The core asynchronous logic of the use case.
  ///
  /// Subclasses must implement this method.
  Future<O> unsafeExecute(I input);

  /// Executes the asynchronous use case with error handling.
  ///
  /// Wraps the call to [unsafeExecute] and handles [AppException]s similarly
  /// to [UseCase.execute].
  Future<O> execute(
    I input, {
    Future<O> Function(AppException)? onError,
  }) async {
    try {
      return await unsafeExecute(input);
    } on AppException catch (ex) {
      if (onError != null) {
        return onError.call(ex);
      } else {
        rethrow;
      }
    }
  }

  /// Executes the asynchronous use case and returns `null` if an [AppException] occurs.
  Future<O?> executeOrNull(I input) async {
    try {
      return await unsafeExecute(input);
    } on AppException {
      return null;
    }
  }
}

/// An abstract class representing a use case that returns a [Stream].
///
/// This is a specialized version of [UseCase] for reactive data flows.
abstract class StreamUseCase<I, O> extends UseCase<I, Stream<O>> {
  /// Default constructor for subclasses.
  const StreamUseCase();
}
