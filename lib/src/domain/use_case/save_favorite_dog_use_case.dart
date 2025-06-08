import '../models/models.dart';
import '../repository/repository.dart';
import 'use_case.dart';

/// A use case for saving a favorite dog.
///
/// This class encapsulates the business logic required to persist a dog
/// marked as a favorite by the user. It follows the Command pattern,
/// where the execution of the action is separated from its declaration.
class SaveFavoriteDogUseCase extends FutureUseCase<DogModel, void> {
  final FavoritesRepository _favoritesRepository;

  /// Creates a [SaveFavoriteDogUseCase] instance.
  ///
  /// Requires a [FavoritesRepository] to interact with the data layer.
  const SaveFavoriteDogUseCase({
    required FavoritesRepository favoritesRepository,
  }) : _favoritesRepository = favoritesRepository;

  @override
  Future<void> unsafeExecute(DogModel input) {
    return _favoritesRepository.saveFavoriteDog(input);
  }
}
