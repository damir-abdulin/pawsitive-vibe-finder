import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for removing a dog from the user's favorites.
///
/// This class encapsulates the business logic for deleting a specific dog
/// from the list of favorites.
class RemoveFavoriteDogUseCase extends FutureUseCase<DogModel, void> {
  final FavoritesRepository _favoritesRepository;

  /// Creates a [RemoveFavoriteDogUseCase] instance.
  ///
  /// Requires a [FavoritesRepository] to interact with the data layer.
  const RemoveFavoriteDogUseCase({
    required FavoritesRepository favoritesRepository,
  }) : _favoritesRepository = favoritesRepository;

  @override
  Future<void> unsafeExecute(DogModel input) {
    return _favoritesRepository.removeFavoriteDog(input);
  }
}
