import 'package:json_annotation/json_annotation.dart';

part 'dog_response_entity.g.dart';

/// Represents the data structure for a random dog fetched from the API.
@JsonSerializable()
class DogResponseEntity {
  /// The URL of the dog's image.
  final String message;

  /// The status of the API response.
  final String status;

  /// Creates an instance of [DogEntity].
  DogResponseEntity({required this.message, required this.status});

  /// Creates a [DogEntity] from a JSON object.
  factory DogResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DogResponseEntityFromJson(json);

  /// Converts a [DogEntity] to a JSON object.
  Map<String, dynamic> toJson() => _$DogResponseEntityToJson(this);
}
