import '../../domain/models/models.dart';
import '../entities/entities.dart';

/// A mapper class for converting between [RandomDogEntity] and [RandomDogModel].
class RandomDogMapper {
  /// Converts a [RandomDogEntity] to a [RandomDogModel].
  ///
  /// The breed is parsed from the image URL.
  static RandomDogModel toDomain(RandomDogEntity entity) {
    final String breed = _parseBreedFromUrl(entity.message);
    return RandomDogModel(imageUrl: entity.message, breed: breed);
  }

  /// Parses the breed name from the dog image URL.
  ///
  /// Example URL: https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg
  /// Expected output: "afghan hound"
  static String _parseBreedFromUrl(String url) {
    try {
      final Uri uri = Uri.parse(url);
      final List<String> segments = uri.pathSegments;
      // The breed information is typically in the second to last segment.
      // e.g., /breeds/hound-afghan/n02088094_1003.jpg -> "hound-afghan"
      if (segments.length >= 2) {
        final String breedSegment = segments[segments.length - 2];
        // Replace hyphens with spaces and capitalize words for better readability.
        return breedSegment
            .split('-')
            .reversed
            .map((String word) => word[0].toUpperCase() + word.substring(1))
            .join(' ');
      }
      return 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }
}
