import 'provider_exception.dart';

/// An exception for errors that occur during network operations.
class NetworkException extends ProviderException {
  const NetworkException(super.message);
}
