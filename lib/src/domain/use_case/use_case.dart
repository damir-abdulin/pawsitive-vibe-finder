import '../exceptions/exceptions.dart';

/// The base class for a use case that returns a value synchronously.
abstract class UseCase<I, O> {
  const UseCase();

  /// Executes the use case with the given input.
  ///
  /// This method contains the core logic and is wrapped by the [execute]
  /// method to provide centralized error handling.
  O unsafeExecute(I input);

  /// Executes the use case and handles any [AppException] that may occur.
  ///
  /// If an [onError] callback is provided, it will be called with the
  /// caught exception, otherwise the exception will be rethrown.
  O execute(I input, {required O Function(AppException)? onError}) {
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
  O? executeOrNull(I input) {
    try {
      return unsafeExecute(input);
    } on AppException catch (_) {
      return null;
    }
  }
}

/// The base class for a use case that returns a [Future].
abstract class FutureUseCase<I, O> {
  const FutureUseCase();

  /// Executes the use case with the given input.
  ///
  /// This method contains the core logic and is wrapped by the [execute]
  /// method to provide centralized error handling.
  Future<O> unsafeExecute(I input);

  /// Executes the use case and handles any [AppException] that may occur.
  ///
  /// If an [onError] callback is provided, it will be called with the
  /// caught exception, otherwise the exception will be rethrown.
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

  /// Executes the use case and returns `null` if an [AppException] occurs.
  Future<O?> executeOrNull(I input) async {
    try {
      return await unsafeExecute(input);
    } on AppException catch (_) {
      return null;
    }
  }
}

/// The base class for a use case that returns a [Stream].
abstract class StreamUseCase<I, O> extends UseCase<I, Stream<O>> {
  const StreamUseCase();
}
