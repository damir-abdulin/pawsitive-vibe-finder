import 'package:equatable/equatable.dart';

/// Represents the domain model for a randomly fetched dog.
class RandomDogModel extends Equatable {
  /// The URL of the dog's image.
  final String imageUrl;

  /// The breed of the dog.
  final String breed;

  /// Creates an instance of [RandomDogModel].
  const RandomDogModel({required this.imageUrl, required this.breed});

  @override
  List<Object> get props => [imageUrl, breed];
}
