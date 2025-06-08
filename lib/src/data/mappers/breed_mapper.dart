import '../../domain/models/breed_model.dart';
import '../entities/entities.dart';

/// A mapper for converting between [BreedResponseEntity] and [BreedModel].
class BreedMapper {
  /// Converts a [BreedResponseEntity] to a list of [BreedModel]s.
  static List<BreedModel> fromEntity(BreedResponseEntity entity) {
    final List<BreedModel> breeds = <BreedModel>[];
    entity.message.forEach((String breed, List<String> subBreeds) {
      if (subBreeds.isEmpty) {
        breeds.add(
          BreedModel(
            name: breed,
            displayName: breed.capitalize(),
            requestPath: breed,
            subBreeds: const <String>[],
          ),
        );
      } else {
        for (final String subBreed in subBreeds) {
          breeds.add(
            BreedModel(
              name: '$breed/$subBreed',
              displayName: '${subBreed.capitalize()} ${breed.capitalize()}',
              requestPath: '$breed/$subBreed',
              subBreeds: const <String>[],
            ),
          );
        }
      }
    });
    return breeds;
  }
}

extension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
