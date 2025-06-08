import '../../domain/domain.dart';
import '../providers/providers.dart';

/// A mapper class for converting between [FavoriteDogEntity] and [DogModel].
///
/// This utility class provides static methods to handle the transformation
/// of data between the data layer's entity representation and the domain
/// layer's model, ensuring a clean separation of concerns.
abstract class FavoriteDogMapper {
  /// Converts a [FavoriteDogEntity] to a [DogModel].
  static DogModel toDomain(FavoriteDogEntity entity) {
    return DogModel(imageUrl: entity.imageUrl, breed: entity.breed);
  }

  /// Converts a [DogModel] to a [FavoriteDogEntity].
  static FavoriteDogEntity toData(DogModel model) {
    return FavoriteDogEntity(imageUrl: model.imageUrl, breed: model.breed);
  }
}
