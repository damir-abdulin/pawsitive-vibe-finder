
/// A model for a dog breed.
///
/// This class represents a dog breed, with its name, display name, and a
/// list of sub-breeds. The [requestPath] is used to fetch images from the
/// Dog CEO API.
class BreedModel {
  /// The name of the breed.
  final String name;

  /// The path for API requests.
  final String requestPath;

  /// The display name of the breed.
  final String displayName;

  /// A list of sub-breeds.
  final List<String> subBreeds;

  /// Creates a [BreedModel].
  const BreedModel({
    required this.name,
    required this.requestPath,
    required this.displayName,
    required this.subBreeds,
  });
}
