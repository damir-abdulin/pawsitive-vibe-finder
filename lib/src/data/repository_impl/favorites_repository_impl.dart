import 'dart:async';

import '../../domain/domain.dart';
import '../mappers/favorite_dog_mapper.dart';
import '../providers/providers.dart';

/// The concrete implementation of the [FavoritesRepository].
///
/// This class interacts with the [FavoriteDogDao] to perform CRUD operations
/// on the local database and uses [FavoriteDogMapper] to convert data between
/// the data and domain layers.
class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoriteDogDao _favoriteDogDao;

  /// Creates an instance of [FavoritesRepositoryImpl].
  ///
  /// Requires a [FavoriteDogDao] to communicate with the database.
  const FavoritesRepositoryImpl({required FavoriteDogDao favoriteDogDao})
    : _favoriteDogDao = favoriteDogDao;

  @override
  Stream<List<DogModel>> getFavoriteDogs() {
    return _favoriteDogDao.watchFavoriteDogs().map(
      (List<FavoriteDogEntity> event) =>
          event.map(FavoriteDogMapper.toDomain).toList(),
    );
  }

  @override
  Future<void> removeFavoriteDog(DogModel dog) {
    final FavoriteDogEntity favoriteDogEntity = FavoriteDogMapper.toData(dog);
    return _favoriteDogDao.deleteFavoriteDog(favoriteDogEntity);
  }

  @override
  Future<void> saveFavoriteDog(DogModel dog) {
    final FavoriteDogEntity favoriteDogEntity = FavoriteDogMapper.toData(dog);
    return _favoriteDogDao.insertFavoriteDog(favoriteDogEntity);
  }
}
