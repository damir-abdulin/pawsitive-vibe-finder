import '../../domain/models/models.dart';
import '../entities/entities.dart';

/// A mapper class for converting between [DogEntity] and [DogModel].
class DogResponseMapper {
  /// Converts a [DogEntity] to a [DogModel].
  ///
  /// The breed is parsed from the image URL.
  static DogModel toDomain(DogResponseEntity entity) {
    final BreedType breed = _parseBreedFromUrl(entity.message);
    return DogModel(imageUrl: entity.message, breed: breed);
  }

  /// Parses the breed name from the dog image URL.
  ///
  /// Example URL: https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg
  /// Expected output: [BreedType.houndAfghan]
  static BreedType _parseBreedFromUrl(String url) {
    try {
      final Uri uri = Uri.parse(url);
      final List<String> segments = uri.pathSegments;
      // The breed information is typically in the second to last segment.
      // e.g., /breeds/hound-afghan/n02088094_1003.jpg -> "hound-afghan"
      if (segments.length >= 2) {
        final String breedSegment = segments[segments.length - 2];
        String enumName = breedSegment;
        if (breedSegment.contains('-')) {
          final List<String> parts = breedSegment.split('-');
          if (parts.length == 2) {
            enumName =
                parts[0] + parts[1][0].toUpperCase() + parts[1].substring(1);
          }
        }
        return BreedType.values.firstWhere(
          (BreedType e) => e.name.toLowerCase() == enumName.toLowerCase(),
          orElse: () => BreedType.mix,
        );
      }
      return BreedType.mix;
    } catch (e) {
      return BreedType.mix;
    }
  }
}
