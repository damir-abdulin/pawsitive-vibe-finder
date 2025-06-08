import 'dart:async';

import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for retrieving a real-time list of favorite dogs.
///
/// This class encapsulates the business logic for fetching all dogs that the
/// user has marked as favorites. It returns a [Stream], allowing the UI to
/// reactively update whenever the list of favorites changes.
class GetFavoriteDogsUseCase extends StreamUseCase<void, List<DogModel>> {
  final FavoritesRepository _favoritesRepository;

  /// Creates a [GetFavoriteDogsUseCase] instance.
  ///
  /// Requires a [FavoritesRepository] to interact with the data layer.
  const GetFavoriteDogsUseCase({
    required FavoritesRepository favoritesRepository,
  }) : _favoritesRepository = favoritesRepository;

  @override
  Stream<List<DogModel>> unsafeExecute(void input) {
    return _favoritesRepository.getFavoriteDogs();
  }
}
