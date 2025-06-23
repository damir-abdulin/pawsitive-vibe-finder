import 'dart:async';

import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case to check if a specific dog is in the user's favorites.
///
/// This class encapsulates the business logic for determining the favorite
/// status of a single dog.
class IsFavoriteDogUseCase extends StreamUseCase<DogModel, bool> {
  final FavoritesRepository _favoritesRepository;

  /// Creates an [IsFavoriteDogUseCase] instance.
  ///
  /// Requires a [FavoritesRepository] to interact with the data layer.
  const IsFavoriteDogUseCase({required FavoritesRepository favoritesRepository})
    : _favoritesRepository = favoritesRepository;

  @override
  Stream<bool> unsafeExecute(DogModel input) {
    return _favoritesRepository.getFavoriteDogs().map(
      (favoriteDogs) =>
          favoriteDogs.any((dog) => dog.imageUrl == input.imageUrl),
    );
  }
}
