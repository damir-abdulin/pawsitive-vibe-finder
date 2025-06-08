import 'package:equatable/equatable.dart';
import 'breed_type.dart';

/// Represents the domain model for a randomly fetched dog.
class DogModel extends Equatable {
  /// The URL of the dog's image.
  final String imageUrl;

  /// The breed of the dog.
  final BreedType breed;

  /// Creates an instance of [DogModel].
  const DogModel({required this.imageUrl, required this.breed});

  @override
  List<Object> get props => <Object>[imageUrl, breed];
}
