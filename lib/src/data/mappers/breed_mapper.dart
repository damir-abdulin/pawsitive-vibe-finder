import '../../domain/models/models.dart';

/// A mapper for breed-related conversions.
class BreedMapper {
  /// Converts a [BreedType] enum to a string suitable for the Dog API URL path.
  ///
  /// For example:
  /// - [BreedType.houndAfghan] becomes "hound/afghan".
  /// - [BreedType.akita] becomes "akita".
  static String fromDomain(BreedType breed) {
    final String breedName = breed.name;
    // Regex to find position before an uppercase letter in the camelCase enum name.
    final RegExp uppercaseRegex = RegExp(r'(?=[A-Z])');
    final List<String> nameParts = breedName.split(uppercaseRegex);
    final List<String> lowercasedParts = nameParts
        .map((String part) => part.toLowerCase())
        .toList();

    return lowercasedParts.join('/');
  }
}
