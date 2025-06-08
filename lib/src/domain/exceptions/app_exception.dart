/// A base class for all exceptions in the application.
class AppException implements Exception {
  /// The error message.
  final String message;

  /// Creates an [AppException].
  const AppException(this.message);
}
