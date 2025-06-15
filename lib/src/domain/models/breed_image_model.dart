import 'package:equatable/equatable.dart';

import 'breed_type.dart';

/// Represents a single dog image within a breed collection.
///
/// This model contains the image URL, breed information, and metadata
/// needed for the slideshow functionality including favoriting and caching.
class BreedImageModel extends Equatable {
  /// The URL of the dog image.
  final String imageUrl;

  /// The breed this image belongs to.
  final BreedType breed;

  /// Whether this image is marked as favorite by the user.
  final bool isFavorite;

  /// Whether this image is cached locally for offline viewing.
  final bool isCached;

  /// Creates an instance of [BreedImageModel].
  const BreedImageModel({
    required this.imageUrl,
    required this.breed,
    this.isFavorite = false,
    this.isCached = false,
  });

  /// Creates a copy of this model with updated values.
  BreedImageModel copyWith({
    String? imageUrl,
    BreedType? breed,
    bool? isFavorite,
    bool? isCached,
  }) {
    return BreedImageModel(
      imageUrl: imageUrl ?? this.imageUrl,
      breed: breed ?? this.breed,
      isFavorite: isFavorite ?? this.isFavorite,
      isCached: isCached ?? this.isCached,
    );
  }

  @override
  List<Object> get props => <Object>[imageUrl, breed, isFavorite, isCached];
}
