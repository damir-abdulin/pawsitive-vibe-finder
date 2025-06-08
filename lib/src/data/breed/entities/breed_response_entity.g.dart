// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedResponseEntity _$BreedResponseEntityFromJson(Map json) =>
    BreedResponseEntity(
      message: (json['message'] as Map).map(
        (k, e) => MapEntry(
          k as String,
          (e as List<dynamic>).map((e) => e as String).toList(),
        ),
      ),
      status: json['status'] as String,
    );

Map<String, dynamic> _$BreedResponseEntityToJson(
  BreedResponseEntity instance,
) => <String, dynamic>{'message': instance.message, 'status': instance.status};
