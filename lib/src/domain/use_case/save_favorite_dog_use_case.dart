import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for saving a dog to the user's favorites.
class SaveFavoriteDogUseCase extends FutureUseCase<DogModel, void> {
  final FavoritesRepository _favoritesRepository;

  /// Creates an instance of [SaveFavoriteDogUseCase].
  SaveFavoriteDogUseCase({required FavoritesRepository favoritesRepository})
    : _favoritesRepository = favoritesRepository;

  @override
  Future<void> unsafeExecute(DogModel input) {
    return _favoritesRepository.saveFavoriteDog(input);
  }
}
