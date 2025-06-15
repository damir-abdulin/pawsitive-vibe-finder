import 'app_exception.dart';

/// Exception thrown when breed images operations fail.
///
/// This exception is specifically for errors related to fetching,
/// caching, or processing breed image collections.
class BreedImagesException extends AppException {
  /// Creates a new [BreedImagesException].
  const BreedImagesException({super.message, super.cause});
}
