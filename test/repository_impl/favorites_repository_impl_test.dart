// ignore_for_file: avoid-late-keyword, no-empty-block

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pawsitive_vibe_finder/src/data/data.dart';
import 'package:pawsitive_vibe_finder/src/domain/domain.dart';

/// Mock implementation of [FavoriteDogDao] for testing purposes.
class MockFavoriteDogDao extends Mock implements FavoriteDogDao {}

void main() {
  group('FavoritesRepositoryImpl', () {
    late FavoritesRepositoryImpl favoritesRepositoryImpl;
    late MockFavoriteDogDao mockFavoriteDogDao;

    setUpAll(() {
      // Register fallback value for FavoriteDogEntity to prevent mocktail errors
      registerFallbackValue(
        const FavoriteDogEntity(
          imageUrl: 'https://fallback.com/image.jpg',
          breed: BreedType.mix,
        ),
      );
    });

    setUp(() {
      mockFavoriteDogDao = MockFavoriteDogDao();
      favoritesRepositoryImpl = FavoritesRepositoryImpl(
        favoriteDogDao: mockFavoriteDogDao,
      );
    });

    group('getFavoriteDogs', () {
      test(
        'should return stream of DogModel when DAO returns stream of FavoriteDogEntity',
        () async {
          // Arrange
          const List<FavoriteDogEntity> expectedFavoriteDogEntities =
              <FavoriteDogEntity>[
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/dog1.jpg',
                  breed: BreedType.labrador,
                ),
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/dog2.jpg',
                  breed: BreedType.beagle,
                ),
              ];

          const List<DogModel> expectedDogModels = <DogModel>[
            DogModel(
              imageUrl: 'https://example.com/dog1.jpg',
              breed: BreedType.labrador,
            ),
            DogModel(
              imageUrl: 'https://example.com/dog2.jpg',
              breed: BreedType.beagle,
            ),
          ];

          final StreamController<List<FavoriteDogEntity>> streamController =
              StreamController<List<FavoriteDogEntity>>();

          when(
            () => mockFavoriteDogDao.watchFavoriteDogs(),
          ).thenAnswer((_) => streamController.stream);

          // Act
          final Stream<List<DogModel>> resultStream = favoritesRepositoryImpl
              .getFavoriteDogs();
          streamController.add(expectedFavoriteDogEntities);

          // Assert
          expect(resultStream, isA<Stream<List<DogModel>>>());
          await expectLater(resultStream, emits(expectedDogModels));

          verify(() => mockFavoriteDogDao.watchFavoriteDogs()).called(1);
          await streamController.close();
        },
      );

      test(
        'should return empty stream when DAO returns empty stream',
        () async {
          // Arrange
          const List<FavoriteDogEntity> expectedFavoriteDogEntities =
              <FavoriteDogEntity>[];
          const List<DogModel> expectedDogModels = <DogModel>[];

          final StreamController<List<FavoriteDogEntity>> streamController =
              StreamController<List<FavoriteDogEntity>>();

          when(
            () => mockFavoriteDogDao.watchFavoriteDogs(),
          ).thenAnswer((_) => streamController.stream);

          // Act
          final Stream<List<DogModel>> resultStream = favoritesRepositoryImpl
              .getFavoriteDogs();
          streamController.add(expectedFavoriteDogEntities);

          // Assert
          await expectLater(resultStream, emits(expectedDogModels));

          verify(() => mockFavoriteDogDao.watchFavoriteDogs()).called(1);
          await streamController.close();
        },
      );

      test(
        'should correctly map FavoriteDogEntity to DogModel with various breed types',
        () async {
          // Arrange
          const List<FavoriteDogEntity> expectedFavoriteDogEntities =
              <FavoriteDogEntity>[
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/bulldog.jpg',
                  breed: BreedType.bulldogEnglish,
                ),
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/germanShepherd.jpg',
                  breed: BreedType.germanshepherd,
                ),
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/mix.jpg',
                  breed: BreedType.mix,
                ),
              ];

          const List<DogModel> expectedDogModels = <DogModel>[
            DogModel(
              imageUrl: 'https://example.com/bulldog.jpg',
              breed: BreedType.bulldogEnglish,
            ),
            DogModel(
              imageUrl: 'https://example.com/germanShepherd.jpg',
              breed: BreedType.germanshepherd,
            ),
            DogModel(
              imageUrl: 'https://example.com/mix.jpg',
              breed: BreedType.mix,
            ),
          ];

          final StreamController<List<FavoriteDogEntity>> streamController =
              StreamController<List<FavoriteDogEntity>>();

          when(
            () => mockFavoriteDogDao.watchFavoriteDogs(),
          ).thenAnswer((_) => streamController.stream);

          // Act
          final Stream<List<DogModel>> resultStream = favoritesRepositoryImpl
              .getFavoriteDogs();
          streamController.add(expectedFavoriteDogEntities);

          // Assert
          await expectLater(resultStream, emits(expectedDogModels));

          verify(() => mockFavoriteDogDao.watchFavoriteDogs()).called(1);
          await streamController.close();
        },
      );
    });

    group('saveFavoriteDog', () {
      test(
        'should call DAO insertFavoriteDog with correctly mapped FavoriteDogEntity',
        () async {
          // Arrange
          const DogModel inputDogModel = DogModel(
            imageUrl: 'https://example.com/dog.jpg',
            breed: BreedType.labrador,
          );

          const FavoriteDogEntity expectedFavoriteDogEntity = FavoriteDogEntity(
            imageUrl: 'https://example.com/dog.jpg',
            breed: BreedType.labrador,
          );

          when(
            () => mockFavoriteDogDao.insertFavoriteDog(any()),
          ).thenAnswer((_) async {});

          // Act
          await favoritesRepositoryImpl.saveFavoriteDog(inputDogModel);

          // Assert
          verify(
            () =>
                mockFavoriteDogDao.insertFavoriteDog(expectedFavoriteDogEntity),
          ).called(1);
        },
      );

      test(
        'should correctly map DogModel to FavoriteDogEntity with various breed types',
        () async {
          // Arrange
          const DogModel inputDogModel = DogModel(
            imageUrl: 'https://example.com/golden-retriever.jpg',
            breed: BreedType.retrieverGolden,
          );

          const FavoriteDogEntity expectedFavoriteDogEntity = FavoriteDogEntity(
            imageUrl: 'https://example.com/golden-retriever.jpg',
            breed: BreedType.retrieverGolden,
          );

          when(
            () => mockFavoriteDogDao.insertFavoriteDog(any()),
          ).thenAnswer((_) async {});

          // Act
          await favoritesRepositoryImpl.saveFavoriteDog(inputDogModel);

          // Assert
          verify(
            () =>
                mockFavoriteDogDao.insertFavoriteDog(expectedFavoriteDogEntity),
          ).called(1);
        },
      );

      test(
        'should complete successfully when DAO operation succeeds',
        () async {
          // Arrange
          const DogModel inputDogModel = DogModel(
            imageUrl: 'https://example.com/dog.jpg',
            breed: BreedType.beagle,
          );

          when(
            () => mockFavoriteDogDao.insertFavoriteDog(any()),
          ).thenAnswer((_) async {});

          // Act
          await favoritesRepositoryImpl.saveFavoriteDog(inputDogModel);

          // Assert
          verify(() => mockFavoriteDogDao.insertFavoriteDog(any())).called(1);
        },
      );
    });

    group('removeFavoriteDog', () {
      test(
        'should call DAO deleteFavoriteDog with correctly mapped FavoriteDogEntity',
        () async {
          // Arrange
          const DogModel inputDogModel = DogModel(
            imageUrl: 'https://example.com/dog-to-remove.jpg',
            breed: BreedType.husky,
          );

          const FavoriteDogEntity expectedFavoriteDogEntity = FavoriteDogEntity(
            imageUrl: 'https://example.com/dog-to-remove.jpg',
            breed: BreedType.husky,
          );

          when(
            () => mockFavoriteDogDao.deleteFavoriteDog(any()),
          ).thenAnswer((_) async {});

          // Act
          await favoritesRepositoryImpl.removeFavoriteDog(inputDogModel);

          // Assert
          verify(
            () =>
                mockFavoriteDogDao.deleteFavoriteDog(expectedFavoriteDogEntity),
          ).called(1);
        },
      );

      test(
        'should correctly map DogModel to FavoriteDogEntity for deletion',
        () async {
          // Arrange
          const DogModel inputDogModel = DogModel(
            imageUrl: 'https://example.com/poodle.jpg',
            breed: BreedType.poodleStandard,
          );

          const FavoriteDogEntity expectedFavoriteDogEntity = FavoriteDogEntity(
            imageUrl: 'https://example.com/poodle.jpg',
            breed: BreedType.poodleStandard,
          );

          when(
            () => mockFavoriteDogDao.deleteFavoriteDog(any()),
          ).thenAnswer((_) async {});

          // Act
          await favoritesRepositoryImpl.removeFavoriteDog(inputDogModel);

          // Assert
          verify(
            () =>
                mockFavoriteDogDao.deleteFavoriteDog(expectedFavoriteDogEntity),
          ).called(1);
        },
      );

      test('should complete successfully when DAO deletion succeeds', () async {
        // Arrange
        const DogModel inputDogModel = DogModel(
          imageUrl: 'https://example.com/dog-to-delete.jpg',
          breed: BreedType.rottweiler,
        );

        when(
          () => mockFavoriteDogDao.deleteFavoriteDog(any()),
        ).thenAnswer((_) async {});

        // Act
        await favoritesRepositoryImpl.removeFavoriteDog(inputDogModel);

        // Assert
        verify(() => mockFavoriteDogDao.deleteFavoriteDog(any())).called(1);
      });
    });

    group('Mapping Integration Tests', () {
      test(
        'should maintain data integrity through save-retrieve cycle',
        () async {
          // Arrange
          const DogModel originalDogModel = DogModel(
            imageUrl: 'https://example.com/integration-test.jpg',
            breed: BreedType.dalmatian,
          );

          const FavoriteDogEntity expectedFavoriteDogEntity = FavoriteDogEntity(
            imageUrl: 'https://example.com/integration-test.jpg',
            breed: BreedType.dalmatian,
          );

          final StreamController<List<FavoriteDogEntity>> streamController =
              StreamController<List<FavoriteDogEntity>>();

          when(
            () => mockFavoriteDogDao.insertFavoriteDog(any()),
          ).thenAnswer((_) async {});
          when(
            () => mockFavoriteDogDao.watchFavoriteDogs(),
          ).thenAnswer((_) => streamController.stream);

          // Act - Save the dog
          await favoritesRepositoryImpl.saveFavoriteDog(originalDogModel);

          // Simulate DAO returning the saved entity
          streamController.add(<FavoriteDogEntity>[expectedFavoriteDogEntity]);

          // Get the dogs stream
          final Stream<List<DogModel>> resultStream = favoritesRepositoryImpl
              .getFavoriteDogs();

          // Assert
          verify(
            () =>
                mockFavoriteDogDao.insertFavoriteDog(expectedFavoriteDogEntity),
          ).called(1);

          await expectLater(resultStream, emits(<DogModel>[originalDogModel]));
          await streamController.close();
        },
      );

      test(
        'should handle round-trip mapping correctly for all breed types',
        () async {
          // Arrange
          const List<DogModel> testDogModels = <DogModel>[
            DogModel(
              imageUrl: 'https://example.com/breed1.jpg',
              breed: BreedType.labrador,
            ),
            DogModel(
              imageUrl: 'https://example.com/breed2.jpg',
              breed: BreedType.retrieverGolden,
            ),
            DogModel(
              imageUrl: 'https://example.com/breed3.jpg',
              breed: BreedType.mix,
            ),
          ];

          const List<FavoriteDogEntity> expectedFavoriteDogEntities =
              <FavoriteDogEntity>[
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/breed1.jpg',
                  breed: BreedType.labrador,
                ),
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/breed2.jpg',
                  breed: BreedType.retrieverGolden,
                ),
                FavoriteDogEntity(
                  imageUrl: 'https://example.com/breed3.jpg',
                  breed: BreedType.mix,
                ),
              ];

          final StreamController<List<FavoriteDogEntity>> streamController =
              StreamController<List<FavoriteDogEntity>>();

          when(
            () => mockFavoriteDogDao.insertFavoriteDog(any()),
          ).thenAnswer((_) async {});
          when(
            () => mockFavoriteDogDao.watchFavoriteDogs(),
          ).thenAnswer((_) => streamController.stream);

          // Act - Save all dogs
          for (final DogModel dogModel in testDogModels) {
            await favoritesRepositoryImpl.saveFavoriteDog(dogModel);
          }

          // Simulate DAO returning all saved entities
          streamController.add(expectedFavoriteDogEntities);

          // Get the dogs stream
          final Stream<List<DogModel>> resultStream = favoritesRepositoryImpl
              .getFavoriteDogs();

          // Assert
          for (int i = 0; i < testDogModels.length; i++) {
            verify(
              () => mockFavoriteDogDao.insertFavoriteDog(
                expectedFavoriteDogEntities[i],
              ),
            ).called(1);
          }

          await expectLater(resultStream, emits(testDogModels));
          await streamController.close();
        },
      );
    });
  });
}
