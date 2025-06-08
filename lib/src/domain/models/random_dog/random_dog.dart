import 'package:equatable/equatable.dart';
import '../breed_type.dart';

/// Represents the domain model for a randomly fetched dog.
class RandomDogModel extends Equatable {
  /// The URL of the dog's image.
  final String imageUrl;

  /// The breed of the dog.
  final BreedType breed;

  /// Creates an instance of [RandomDogModel].
  const RandomDogModel({required this.imageUrl, required this.breed});

  /// Creates an instance of [RandomDogModel] from a JSON object.
  factory RandomDogModel.fromJson(Map<String, dynamic> json) {
    return RandomDogModel(
      imageUrl: json['imageUrl'] as String,
      breed: BreedType.values.byName(
        json['breed'] as String? ?? BreedType.mix.name,
      ),
    );
  }

  /// Converts this [RandomDogModel] instance to a JSON object.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{'imageUrl': imageUrl, 'breed': breed.name};
  }

  @override
  List<Object> get props => <Object>[imageUrl, breed];
}
