import 'package:json_annotation/json_annotation.dart';

part 'random_dog_entity.g.dart';

/// Represents the data structure for a random dog fetched from the API.
@JsonSerializable()
class RandomDogEntity {
  /// The URL of the dog's image.
  final String message;

  /// The status of the API response.
  final String status;

  /// Creates an instance of [RandomDogEntity].
  RandomDogEntity({required this.message, required this.status});

  /// Creates a [RandomDogEntity] from a JSON object.
  factory RandomDogEntity.fromJson(Map<String, dynamic> json) =>
      _$RandomDogEntityFromJson(json);

  /// Converts a [RandomDogEntity] to a JSON object.
  Map<String, dynamic> toJson() => _$RandomDogEntityToJson(this);
}
