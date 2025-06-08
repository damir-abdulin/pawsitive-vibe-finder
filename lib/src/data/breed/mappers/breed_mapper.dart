import '../../../domain/breed/models/breed_model.dart';
import '../entities/breed_response_entity.dart';

/// A mapper for converting breed data between the data and domain layers.
class BreedMapper {
  /// Converts a [BreedResponseEntity] to a list of [BreedModel].
  static List<BreedModel> fromEntity(BreedResponseEntity entity) {
    final List<BreedModel> breeds = <BreedModel>[];
    entity.message.forEach((String breed, List<String> subBreeds) {
      if (subBreeds.isEmpty) {
        breeds.add(
          BreedModel(displayName: _capitalize(breed), requestPath: breed),
        );
      } else {
        for (final String subBreed in subBreeds) {
          breeds.add(
            BreedModel(
              displayName: '${_capitalize(subBreed)} ${_capitalize(breed)}',
              requestPath: '$breed/$subBreed',
            ),
          );
        }
      }
    });
    // Sort alphabetically by display name
    breeds.sort(
      (BreedModel a, BreedModel b) => a.displayName.compareTo(b.displayName),
    );
    return breeds;
  }

  static String _capitalize(String s) {
    if (s.isEmpty) {
      return '';
    }
    return s[0].toUpperCase() + s.substring(1);
  }
}
