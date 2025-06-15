import 'package:json_annotation/json_annotation.dart';

part 'breed_images_response_entity.g.dart';

/// Represents the API response for breed images from dog.ceo API.
///
/// Example response:
/// ```json
/// {
///   "message": [
///     "https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg",
///     "https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg"
///   ],
///   "status": "success"
/// }
/// ```
@JsonSerializable()
class BreedImagesResponseEntity {
  /// List of image URLs for the breed.
  final List<String> message;

  /// The status of the API response.
  final String status;

  /// Creates an instance of [BreedImagesResponseEntity].
  const BreedImagesResponseEntity({
    required this.message,
    required this.status,
  });

  /// Creates a [BreedImagesResponseEntity] from a JSON object.
  factory BreedImagesResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BreedImagesResponseEntityFromJson(json);

  /// Converts a [BreedImagesResponseEntity] to a JSON object.
  Map<String, dynamic> toJson() => _$BreedImagesResponseEntityToJson(this);
}
