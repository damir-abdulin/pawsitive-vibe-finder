import 'package:json_annotation/json_annotation.dart';

part 'dog_entity.g.dart';

@JsonSerializable()
class DogEntity {
  final String imageUrl;
  final String breed;

  DogEntity({required this.imageUrl, required this.breed});

  factory DogEntity.fromJson(Map<String, dynamic> json) =>
      _$DogEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DogEntityToJson(this);
}
