import 'package:pawsitive_vibe_finder/src/data/entities/entities.dart';
import 'package:pawsitive_vibe_finder/src/domain/models/models.dart';

/// A mapper class for converting between [RandomDogEntity] and [RandomDogModel].
class RandomDogMapper {
  /// Converts a [RandomDogEntity] to a [RandomDogModel].
  ///
  /// The breed is parsed from the image URL.
  static RandomDogModel toDomain(RandomDogEntity entity) {
    final breed = _parseBreedFromUrl(entity.message);
    return RandomDogModel(imageUrl: entity.message, breed: breed);
  }

  /// Parses the breed name from the dog image URL.
  ///
  /// Example URL: https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg
  /// Expected output: "afghan hound"
  static String _parseBreedFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      // The breed information is typically in the second to last segment.
      // e.g., /breeds/hound-afghan/n02088094_1003.jpg -> "hound-afghan"
      if (segments.length >= 2) {
        final breedSegment = segments[segments.length - 2];
        // Replace hyphens with spaces and capitalize words for better readability.
        return breedSegment
            .split('-')
            .reversed
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join(' ');
      }
      return 'Unknown';
    } catch (e) {
      return 'Unknown';
    }
  }
}
