/// Base class for all domain exceptions.
///
/// This class allows for a structured and predictable way of handling errors
/// that originate from the domain layer, such as business rule violations or
/// data processing failures.
abstract class AppException implements Exception {
  /// An optional message providing more details about the exception.
  final String? message;

  /// An optional reference to the original exception or error that caused this
  /// application-specific exception.
  final Object? cause;

  /// Creates a new [AppException].
  ///
  /// The [message] and [cause] are optional.
  const AppException({this.message, this.cause});
}
