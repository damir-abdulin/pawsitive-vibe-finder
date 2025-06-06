/// A base class for all application-specific exceptions.
class AppException implements Exception {
  final String? message;

  const AppException({this.message});

  @override
  String toString() {
    return message ?? 'An application error occurred.';
  }
}
