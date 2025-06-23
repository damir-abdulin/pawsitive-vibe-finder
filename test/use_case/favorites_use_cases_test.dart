// ignore_for_file: avoid-late-keyword, no-empty-block, member-ordering

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pawsitive_vibe_finder/src/domain/domain.dart';

/// Mock implementation of [FavoritesRepository] for testing purposes.
class MockFavoritesRepository extends Mock implements FavoritesRepository {}

class FakeDogModel extends Fake implements DogModel {}

class _TestAppException implements AppException {
  @override
  final String? message;
  @override
  final Object? cause;

  const _TestAppException(this.message, {this.cause});
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeDogModel());
  });

  group('Favorites Use Cases Tests', () {
    late MockFavoritesRepository mockFavoritesRepository;

    setUp(() {
      mockFavoritesRepository = MockFavoritesRepository();
    });

    group('GetFavoriteDogsUseCase', () {
      late GetFavoriteDogsUseCase getFavoriteDogsUseCase;
      late StreamController<List<DogModel>> streamController;

      setUp(() {
        getFavoriteDogsUseCase = GetFavoriteDogsUseCase(
          favoritesRepository: mockFavoritesRepository,
        );
        streamController = StreamController<List<DogModel>>.broadcast();
        when(
          () => mockFavoritesRepository.getFavoriteDogs(),
        ).thenAnswer((_) => streamController.stream);
      });

      tearDown(() {
        streamController.close();
      });

      test('should return stream of favorite dogs', () {
        // Arrange
        final expectedDogs = [
          const DogModel(imageUrl: 'dog1.jpg', breed: BreedType.beagle),
        ];

        // Act
        final stream = getFavoriteDogsUseCase.unsafeExecute(null);

        // Assert
        expect(stream, emits(expectedDogs));

        // Act again
        streamController.add(expectedDogs);
      });

      test('should emit error when repository throws', () {
        // Arrange
        final exception = Exception('Error');

        // Act
        final stream = getFavoriteDogsUseCase.unsafeExecute(null);

        // Assert
        expect(stream, emitsError(exception));

        // Act again
        streamController.addError(exception);
      });
    });

    group('SaveFavoriteDogUseCase', () {
      late SaveFavoriteDogUseCase saveFavoriteDogUseCase;

      setUp(() {
        saveFavoriteDogUseCase = SaveFavoriteDogUseCase(
          favoritesRepository: mockFavoritesRepository,
        );
      });

      test(
        'should add dog to favorites when repository call succeeds',
        () async {
          // Arrange
          const DogModel inputDog = DogModel(
            imageUrl: 'https://example.com/dog1.jpg',
            breed: BreedType.labrador,
          );

          when(
            () => mockFavoritesRepository.saveFavoriteDog(inputDog),
          ).thenAnswer((_) async {});

          // Act
          await saveFavoriteDogUseCase.unsafeExecute(inputDog);

          // Assert
          verify(
            () => mockFavoritesRepository.saveFavoriteDog(inputDog),
          ).called(1);
        },
      );

      test(
        'should propagate AppException when repository fails to add favorite',
        () async {
          // Arrange
          const DogModel inputDog = DogModel(
            imageUrl: 'https://example.com/dog1.jpg',
            breed: BreedType.labrador,
          );
          const _TestAppException testException = _TestAppException(
            'Failed to save favorite',
          );

          when(
            () => mockFavoritesRepository.saveFavoriteDog(inputDog),
          ).thenThrow(testException);

          // Act & Assert
          expect(
            () => saveFavoriteDogUseCase.unsafeExecute(inputDog),
            throwsA(testException),
          );

          verify(
            () => mockFavoritesRepository.saveFavoriteDog(inputDog),
          ).called(1);
        },
      );
    });

    group('RemoveFavoriteDogUseCase', () {
      late RemoveFavoriteDogUseCase removeFavoriteDogUseCase;

      setUp(() {
        removeFavoriteDogUseCase = RemoveFavoriteDogUseCase(
          favoritesRepository: mockFavoritesRepository,
        );
      });

      test(
        'should remove dog from favorites when repository call succeeds',
        () async {
          // Arrange
          const DogModel inputDog = DogModel(
            imageUrl: 'https://example.com/dog1.jpg',
            breed: BreedType.labrador,
          );

          when(
            () => mockFavoritesRepository.removeFavoriteDog(inputDog),
          ).thenAnswer((_) async {});

          // Act
          await removeFavoriteDogUseCase.unsafeExecute(inputDog);

          // Assert
          verify(
            () => mockFavoritesRepository.removeFavoriteDog(inputDog),
          ).called(1);
        },
      );

      test(
        'should propagate AppException when repository fails to remove favorite',
        () async {
          // Arrange
          const DogModel inputDog = DogModel(
            imageUrl: 'https://example.com/dog1.jpg',
            breed: BreedType.labrador,
          );
          const _TestAppException testException = _TestAppException(
            'Failed to remove favorite',
          );

          when(
            () => mockFavoritesRepository.removeFavoriteDog(inputDog),
          ).thenThrow(testException);

          // Act & Assert
          expect(
            () => removeFavoriteDogUseCase.unsafeExecute(inputDog),
            throwsA(testException),
          );

          verify(
            () => mockFavoritesRepository.removeFavoriteDog(inputDog),
          ).called(1);
        },
      );
    });

    group('IsFavoriteDogUseCase', () {
      late IsFavoriteDogUseCase isFavoriteDogUseCase;
      late StreamController<List<DogModel>> streamController;

      setUp(() {
        isFavoriteDogUseCase = IsFavoriteDogUseCase(
          favoritesRepository: mockFavoritesRepository,
        );
        streamController = StreamController<List<DogModel>>.broadcast();
        when(
          () => mockFavoritesRepository.getFavoriteDogs(),
        ).thenAnswer((_) => streamController.stream);
      });

      tearDown(() {
        streamController.close();
      });

      test('should return true if dog is in favorites', () async {
        // Arrange
        const dog = DogModel(
          imageUrl: 'https://example.com/cute_dog.jpg',
          breed: BreedType.pug,
        );
        final stream = isFavoriteDogUseCase.unsafeExecute(dog);

        // Act
        streamController.add([dog]);

        // Assert
        await expectLater(stream, emits(true));
      });

      test('should return false if dog is not in favorites', () async {
        // Arrange
        const dog = DogModel(
          imageUrl: 'https://example.com/cute_dog.jpg',
          breed: BreedType.pug,
        );
        const otherDog = DogModel(
          imageUrl: 'https://example.com/another_dog.jpg',
          breed: BreedType.beagle,
        );
        final stream = isFavoriteDogUseCase.unsafeExecute(dog);

        // Act
        streamController.add([otherDog]);

        // Assert
        await expectLater(stream, emits(false));
      });

      test('should emit false for an empty list of favorites', () async {
        // Arrange
        const dog = DogModel(
          imageUrl: 'https://example.com/cute_dog.jpg',
          breed: BreedType.pug,
        );
        final stream = isFavoriteDogUseCase.unsafeExecute(dog);

        // Act
        streamController.add([]);

        // Assert
        await expectLater(stream, emits(false));
      });
    });
  });
}
