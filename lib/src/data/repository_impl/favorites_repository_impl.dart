import '../../domain/domain.dart';

/// A mock implementation of the [FavoritesRepository].
///
/// This class simulates saving a favorite dog by printing to the console.
/// It can be replaced with a real database implementation in the future.
class FavoritesRepositoryImpl implements FavoritesRepository {
  /// Creates an instance of [FavoritesRepositoryImpl].
  const FavoritesRepositoryImpl();

  @override
  Future<void> saveFavoriteDog(RandomDogModel dog) async {
    // Mock implementation: just print the action.
    // In a real implementation, this would save the dog to a local database.
    // ignore: avoid_print
    print('Dog saved to favorites: ${dog.breed} - ${dog.imageUrl}');
    return Future<void>.value();
  }
}
