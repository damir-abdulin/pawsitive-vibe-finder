import 'package:pawsitive_vibe_finder/src/domain/models/models.dart';
import 'package:pawsitive_vibe_finder/src/domain/repository/repository.dart';
import 'package:pawsitive_vibe_finder/src/domain/use_case/use_case.dart';

/// A use case for saving a dog to the user's favorites.
class SaveFavoriteDogUseCase extends FutureUseCase<RandomDogModel, void> {
  final FavoritesRepository _favoritesRepository;

  /// Creates an instance of [SaveFavoriteDogUseCase].
  SaveFavoriteDogUseCase({required FavoritesRepository favoritesRepository})
    : _favoritesRepository = favoritesRepository;

  @override
  Future<void> unsafeExecute(RandomDogModel input) {
    return _favoritesRepository.saveFavoriteDog(input);
  }
}
