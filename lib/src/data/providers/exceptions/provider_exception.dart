/// A base class for all data provider-related exceptions.
class ProviderException implements Exception {
  final String message;

  const ProviderException(this.message);

  @override
  String toString() => 'ProviderException: $message';
}
