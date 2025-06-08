import 'dart:async';

import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case to check if a specific dog is in the user's favorites.
///
/// This class encapsulates the business logic for determining the favorite
/// status of a single dog.
class IsFavoriteDogUseCase extends FutureUseCase<DogModel, bool> {
  final FavoritesRepository _favoritesRepository;

  /// Creates an [IsFavoriteDogUseCase] instance.
  ///
  /// Requires a [FavoritesRepository] to interact with the data layer.
  const IsFavoriteDogUseCase({required FavoritesRepository favoritesRepository})
    : _favoritesRepository = favoritesRepository;

  @override
  Future<bool> unsafeExecute(DogModel input) async {
    final favoriteDogs = await _favoritesRepository.getFavoriteDogs().first;
    return favoriteDogs.any((dog) => dog.imageUrl == input.imageUrl);
  }
}
