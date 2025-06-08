/// An exception thrown by the [BreedProvider].
class BreedProviderException implements Exception {
  /// Creates a [BreedProviderException].
  const BreedProviderException(this.message);

  /// The error message.
  final String message;
} 