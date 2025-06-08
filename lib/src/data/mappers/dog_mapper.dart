import '../../domain/domain.dart';
import '../entities/dog/dog_entity.dart';

class DogMapper {
  static DogEntity fromDomain(DogModel model) {
    return DogEntity(imageUrl: model.imageUrl, breed: model.breed.name);
  }

  static DogModel toDomain(DogEntity entity) {
    return DogModel(
      imageUrl: entity.imageUrl,
      breed: BreedType.values.byName(entity.breed),
    );
  }
}
