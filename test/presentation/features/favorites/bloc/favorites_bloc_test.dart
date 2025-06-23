// ignore_for_file: avoid-late-keyword, no-empty-block, avoid-dynamic

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pawsitive_vibe_finder/src/domain/domain.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/favorites/bloc/favorites_bloc.dart';

// Mock classes
class MockGetFavoriteDogsUseCase extends Mock
    implements GetFavoriteDogsUseCase {}

class MockSaveFavoriteDogUseCase extends Mock
    implements SaveFavoriteDogUseCase {}

class MockRemoveFavoriteDogUseCase extends Mock
    implements RemoveFavoriteDogUseCase {}

class FakeDogModel extends Fake implements DogModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeDogModel());
  });

  group('FavoritesBloc', () {
    late FavoritesBloc favoritesBloc;
    late MockGetFavoriteDogsUseCase mockGetFavoriteDogsUseCase;
    late MockSaveFavoriteDogUseCase mockSaveFavoriteDogUseCase;
    late MockRemoveFavoriteDogUseCase mockRemoveFavoriteDogUseCase;

    // Test data
    const DogModel testDog1 = DogModel(
      imageUrl: 'https://example.com/dog1.jpg',
      breed: BreedType.labrador,
    );
    const DogModel testDog2 = DogModel(
      imageUrl: 'https://example.com/dog2.jpg',
      breed: BreedType.retrieverGolden,
    );
    final List<DogModel> testDogsList = <DogModel>[testDog1, testDog2];

    setUp(() {
      // Arrange
      mockGetFavoriteDogsUseCase = MockGetFavoriteDogsUseCase();
      mockSaveFavoriteDogUseCase = MockSaveFavoriteDogUseCase();
      mockRemoveFavoriteDogUseCase = MockRemoveFavoriteDogUseCase();

      favoritesBloc = FavoritesBloc(
        getFavoriteDogsUseCase: mockGetFavoriteDogsUseCase,
        saveFavoriteDogUseCase: mockSaveFavoriteDogUseCase,
        removeFavoriteDogUseCase: mockRemoveFavoriteDogUseCase,
      );

      // Setup default mock behavior
      when(
        () => mockSaveFavoriteDogUseCase.execute(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockRemoveFavoriteDogUseCase.execute(any()),
      ).thenAnswer((_) async {});
    });

    tearDown(() {
      favoritesBloc.close();
    });

    test('initial state is FavoritesInitial', () {
      // Assert
      expect(favoritesBloc.state, FavoritesInitial());
    });

    group('FavoritesStarted (LoadFavorites)', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'emits [FavoritesLoadInProgress, FavoritesLoadSuccess] when dogs are loaded successfully',
        build: () {
          // Arrange
          when(
            () => mockGetFavoriteDogsUseCase.execute(any()),
          ).thenAnswer((_) => Stream<List<DogModel>>.value(testDogsList));

          return favoritesBloc;
        },
        act: (FavoritesBloc bloc) {
          // Act
          bloc.add(FavoritesStarted());
        },
        expect: () => <FavoritesState>[
          // Assert
          FavoritesLoadInProgress(),
          FavoritesLoadSuccess(favoriteDogs: testDogsList),
        ],
        verify: (_) {
          verify(() => mockGetFavoriteDogsUseCase.execute(null)).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'emits [FavoritesLoadInProgress, FavoritesEmpty] when no dogs are returned',
        build: () {
          // Arrange
          when(
            () => mockGetFavoriteDogsUseCase.execute(any()),
          ).thenAnswer((_) => Stream<List<DogModel>>.value(<DogModel>[]));

          return favoritesBloc;
        },
        act: (FavoritesBloc bloc) {
          // Act
          bloc.add(FavoritesStarted());
        },
        expect: () => <FavoritesState>[
          // Assert
          FavoritesLoadInProgress(),
          FavoritesEmpty(),
        ],
        verify: (_) {
          verify(() => mockGetFavoriteDogsUseCase.execute(null)).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'emits [FavoritesLoadInProgress, FavoritesLoadFailure] when use case throws exception',
        build: () {
          // Arrange
          when(() => mockGetFavoriteDogsUseCase.execute(any())).thenAnswer(
            (_) => Stream<List<DogModel>>.error(Exception('Test error')),
          );

          return favoritesBloc;
        },
        act: (FavoritesBloc bloc) {
          // Act
          bloc.add(FavoritesStarted());
        },
        expect: () => <FavoritesState>[
          // Assert
          FavoritesLoadInProgress(),
          const FavoritesLoadFailure(message: 'Exception: Test error'),
        ],
        verify: (_) {
          verify(() => mockGetFavoriteDogsUseCase.execute(null)).called(1);
        },
      );
    });

    group('FavoriteDogRemoved (RemoveFavorite)', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'calls RemoveFavoriteDogUseCase when dog is removed',
        build: () => favoritesBloc,
        act: (FavoritesBloc bloc) {
          // Act
          bloc.add(const FavoriteDogRemoved(dog: testDog1));
        },
        expect: () => <dynamic>[],
        verify: (_) {
          // Assert
          verify(
            () => mockRemoveFavoriteDogUseCase.execute(testDog1),
          ).called(1);
        },
      );

      blocTest<FavoritesBloc, FavoritesState>(
        'handles exception from RemoveFavoriteDogUseCase gracefully',
        build: () {
          // Arrange
          when(
            () => mockRemoveFavoriteDogUseCase.execute(any()),
          ).thenThrow(Exception('Remove failed'));

          return favoritesBloc;
        },
        act: (FavoritesBloc bloc) {
          // Act
          bloc.add(const FavoriteDogRemoved(dog: testDog1));
        },
        expect: () => <dynamic>[],
        verify: (_) {
          verify(
            () => mockRemoveFavoriteDogUseCase.execute(testDog1),
          ).called(1);
        },
      );
    });

    group('FavoriteDogAdded', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'calls SaveFavoriteDogUseCase when dog is added',
        build: () => favoritesBloc,
        act: (FavoritesBloc bloc) {
          // Act
          bloc.add(const FavoriteDogAdded(dog: testDog1));
        },
        expect: () => <dynamic>[],
        verify: (_) {
          // Assert
          verify(() => mockSaveFavoriteDogUseCase.execute(testDog1)).called(1);
        },
      );
    });

    group('FavoritesRefreshed', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'emits [FavoritesLoadInProgress, FavoritesLoadSuccess] when refresh is successful',
        build: () {
          // Arrange
          when(
            () => mockGetFavoriteDogsUseCase.execute(any()),
          ).thenAnswer((_) => Stream<List<DogModel>>.value(testDogsList));

          return favoritesBloc;
        },
        act: (FavoritesBloc bloc) {
          // Act
          bloc.add(FavoritesRefreshed());
        },
        expect: () => <FavoritesState>[
          // Assert
          FavoritesLoadInProgress(),
          FavoritesLoadSuccess(favoriteDogs: testDogsList),
        ],
        verify: (_) {
          verify(() => mockGetFavoriteDogsUseCase.execute(null)).called(1);
        },
      );
    });
  });
}
