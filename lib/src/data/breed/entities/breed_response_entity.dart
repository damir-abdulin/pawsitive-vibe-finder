import 'package:json_annotation/json_annotation.dart';

part 'breed_response_entity.g.dart';

/// The response entity for the breeds list API.
@JsonSerializable()
class BreedResponseEntity {
  /// The map of breeds and their sub-breeds.
  final Map<String, List<String>> message;

  /// The status of the response.
  final String status;

  /// Creates a [BreedResponseEntity].
  const BreedResponseEntity({required this.message, required this.status});

  /// Creates a [BreedResponseEntity] from a JSON object.
  factory BreedResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BreedResponseEntityFromJson(json);

  /// Converts this [BreedResponseEntity] to a JSON object.
  Map<String, dynamic> toJson() => _$BreedResponseEntityToJson(this);
}
