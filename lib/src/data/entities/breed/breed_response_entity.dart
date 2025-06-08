import 'package:json_annotation/json_annotation.dart';

part 'breed_response_entity.g.dart';

@JsonSerializable()
class BreedResponseEntity {
  final Map<String, List<String>> message;

  BreedResponseEntity({required this.message});

  factory BreedResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BreedResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BreedResponseEntityToJson(this);
}
