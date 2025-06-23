// ignore_for_file: avoid-late-keyword

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pawsitive_vibe_finder/src/domain/domain.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/breed_images_slideshow/bloc/breed_images_slideshow_bloc.dart';

class MockGetBreedImagesUseCase extends Mock implements GetBreedImagesUseCase {}

class MockToggleBreedImageFavoriteUseCase extends Mock
    implements ToggleBreedImageFavoriteUseCase {}

class FakeGetBreedImagesInput extends Fake implements GetBreedImagesInput {}

class FakeToggleBreedImageFavoriteInput extends Fake
    implements ToggleBreedImageFavoriteInput {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeGetBreedImagesInput());
    registerFallbackValue(FakeToggleBreedImageFavoriteInput());
  });

  group('BreedImagesSlideshowBloc', () {
    late BreedImagesSlideshowBloc bloc;
    late MockGetBreedImagesUseCase mockGetBreedImagesUseCase;
    late MockToggleBreedImageFavoriteUseCase mockToggleFavoriteUseCase;

    // Test data
    const testBreed = BreedType.beagle;
    final testImage = BreedImageModel(imageUrl: 'test.jpg', breed: testBreed);
    final testBreedImages = BreedImagesModel(
      breed: testBreed,
      images: [testImage],
    );

    setUp(() {
      mockGetBreedImagesUseCase = MockGetBreedImagesUseCase();
      mockToggleFavoriteUseCase = MockToggleBreedImageFavoriteUseCase();
      bloc = BreedImagesSlideshowBloc(
        getBreedImagesUseCase: mockGetBreedImagesUseCase,
        toggleFavoriteUseCase: mockToggleFavoriteUseCase,
      );
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is BreedImagesSlideshowInitial', () {
      expect(bloc.state, isA<BreedImagesSlideshowInitial>());
    });

    group('LoadBreedImagesEvent', () {
      blocTest<BreedImagesSlideshowBloc, BreedImagesSlideshowState>(
        'should emit loading then loaded states when images are successfully retrieved',
        build: () {
          when(
            () => mockGetBreedImagesUseCase.execute(
              any(),
              onError: any(named: 'onError'),
            ),
          ).thenAnswer((_) async => testBreedImages);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadBreedImagesEvent(breed: testBreed)),
        expect: () => [
          BreedImagesSlideshowLoading(),
          BreedImagesSlideshowLoaded(
            breedImages: testBreedImages,
            currentIndex: 0,
          ),
        ],
        verify: (_) {
          verify(
            () => mockGetBreedImagesUseCase.execute(
              any(),
              onError: any(named: 'onError'),
            ),
          ).called(1);
        },
      );

      blocTest<BreedImagesSlideshowBloc, BreedImagesSlideshowState>(
        'should emit loading then error states when image loading fails',
        build: () {
          when(
            () => mockGetBreedImagesUseCase.execute(
              any(),
              onError: any(named: 'onError'),
            ),
          ).thenThrow(const BreedImagesException(message: 'Failed to load'));
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadBreedImagesEvent(breed: testBreed)),
        expect: () => [
          BreedImagesSlideshowLoading(),
          const BreedImagesSlideshowError(
            message: 'Failed to load',
            breed: testBreed,
          ),
        ],
      );
    });

    group('ToggleFavoriteEvent', () {
      final updatedImage = testImage.copyWith(isFavorite: true);

      blocTest<BreedImagesSlideshowBloc, BreedImagesSlideshowState>(
        'should update favorite status when toggled from loaded state',
        build: () {
          when(
            () => mockToggleFavoriteUseCase.execute(
              any(),
              onError: any(named: 'onError'),
            ),
          ).thenAnswer((_) async => updatedImage);
          return bloc;
        },
        seed: () => BreedImagesSlideshowLoaded(
          breedImages: testBreedImages,
          currentIndex: 0,
        ),
        act: (bloc) => bloc.add(const ToggleFavoriteEvent()),
        expect: () => [
          isA<BreedImagesSlideshowLoaded>().having(
            (state) => state.breedImages.images.first.isFavorite,
            'isFavorite',
            isTrue,
          ),
        ],
      );

      blocTest<BreedImagesSlideshowBloc, BreedImagesSlideshowState>(
        'should not change state when favorite toggle fails',
        build: () {
          when(
            () => mockToggleFavoriteUseCase.execute(
              any(),
              onError: any(named: 'onError'),
            ),
          ).thenThrow(const BreedImagesException(message: 'Toggle failed'));
          return bloc;
        },
        seed: () => BreedImagesSlideshowLoaded(
          breedImages: testBreedImages,
          currentIndex: 0,
        ),
        act: (bloc) => bloc.add(const ToggleFavoriteEvent()),
        expect: () => [], // No state change
      );
    });
  });
}
