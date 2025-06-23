// ignore_for_file: avoid-late-keyword

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pawsitive_vibe_finder/src/data/data.dart';
import 'package:pawsitive_vibe_finder/src/domain/domain.dart';

/// Mock classes for dependencies
class MockDogApiProvider extends Mock implements DogApiProvider {}

class MockBreedImagesCacheDao extends Mock implements BreedImagesCacheDao {}

class MockIsFavoriteDogUseCase extends Mock implements IsFavoriteDogUseCase {}

void main() {
  group('BreedImagesRepositoryImpl Tests', () {
    late BreedImagesRepositoryImpl repository;
    late MockDogApiProvider mockDogApiProvider;
    late MockBreedImagesCacheDao mockCacheDao;
    late MockIsFavoriteDogUseCase mockIsFavoriteDogUseCase;

    // Test data
    const BreedType testBreed = BreedType.akita;
    const String testBreedPath = 'akita';
    const List<String> testImageUrls = <String>[
      'https://images.dog.ceo/breeds/akita/n02110063_1.jpg',
      'https://images.dog.ceo/breeds/akita/n02110063_2.jpg',
      'https://images.dog.ceo/breeds/akita/n02110063_3.jpg',
    ];

    const BreedImagesResponseEntity testApiResponse = BreedImagesResponseEntity(
      message: testImageUrls,
      status: 'success',
    );

    setUpAll(() {
      registerFallbackValue(
        const DogModel(
          imageUrl: 'https://example.com/dog.jpg',
          breed: BreedType.akita,
        ),
      );
    });

    setUp(() {
      // Arrange - Create mock dependencies
      mockDogApiProvider = MockDogApiProvider();
      mockCacheDao = MockBreedImagesCacheDao();
      mockIsFavoriteDogUseCase = MockIsFavoriteDogUseCase();

      repository = BreedImagesRepositoryImpl(
        dogApiProvider: mockDogApiProvider,
        cacheDao: mockCacheDao,
        isFavoriteDogUseCase: mockIsFavoriteDogUseCase,
      );
    });

    group('getBreedImages', () {
      test(
        'should fetch from network and return domain model when successful',
        () async {
          // Arrange
          when(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).thenAnswer((_) async => testApiResponse);
          when(
            () => mockIsFavoriteDogUseCase.execute(
              any(),
              onError: any(named: 'onError'),
            ),
          ).thenAnswer((_) => Stream.value(false));

          // Act
          final BreedImagesModel result = await repository.getBreedImages(
            testBreed,
          );

          // Assert
          expect(result.breed, equals(testBreed));
          expect(result.images, hasLength(testImageUrls.length));
          expect(result.hasImages, isTrue);
          expect(result.images.first.imageUrl, equals(testImageUrls.first));
          expect(result.images.first.breed, equals(testBreed));
          expect(result.images.first.isFavorite, isFalse);

          // Verify interactions
          verify(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).called(1);
          verify(
            () => mockIsFavoriteDogUseCase.execute(
              any(),
              onError: any(named: 'onError'),
            ),
          ).called(testImageUrls.length);
        },
      );

      test('should load favorite status for each image', () async {
        // Arrange
        when(
          () => mockDogApiProvider.getBreedImages(testBreedPath),
        ).thenAnswer((_) async => testApiResponse);
        when(
          () => mockIsFavoriteDogUseCase.execute(
            any(),
            onError: any(named: 'onError'),
          ),
        ).thenAnswer((Invocation invocation) {
          final DogModel dog = invocation.positionalArguments.first as DogModel;

          // Make the first image favorite
          return Stream.value(dog.imageUrl == testImageUrls.first);
        });

        // Act
        final BreedImagesModel result = await repository.getBreedImages(
          testBreed,
        );

        // Assert
        expect(result.images.first.isFavorite, isTrue);
        expect(result.images[1].isFavorite, isFalse);
        expect(result.images[2].isFavorite, isFalse);
      });

      test('should throw BreedImagesException when no images found', () async {
        // Arrange
        const BreedImagesResponseEntity emptyResponse =
            BreedImagesResponseEntity(message: <String>[], status: 'success');
        when(
          () => mockDogApiProvider.getBreedImages(testBreedPath),
        ).thenAnswer((_) async => emptyResponse);

        // Act & Assert
        expect(
          () => repository.getBreedImages(testBreed),
          throwsA(
            isA<BreedImagesException>().having(
              (BreedImagesException e) => e.message,
              'message',
              contains(
                'No barks about it, we could not find any images for this breed!',
              ),
            ),
          ),
        );

        verify(
          () => mockDogApiProvider.getBreedImages(testBreedPath),
        ).called(1);
      });

      test(
        'should handle NetworkException and convert to BreedImagesException',
        () async {
          // Arrange
          when(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).thenThrow(const NetworkException('Network error'));

          // Act & Assert
          expect(
            () => repository.getBreedImages(testBreed),
            throwsA(
              isA<BreedImagesException>().having(
                (BreedImagesException e) => e.message,
                'message',
                contains(
                  'Failed to load the gallery. Please check your connection and try again.',
                ),
              ),
            ),
          );

          verify(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).called(1);
        },
      );

      test(
        'should handle ProviderException and convert to BreedImagesException',
        () async {
          // Arrange
          when(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).thenThrow(const ProviderException('Provider error'));

          // Act & Assert
          expect(
            () => repository.getBreedImages(testBreed),
            throwsA(
              isA<BreedImagesException>().having(
                (BreedImagesException e) => e.message,
                'message',
                contains(
                  'Failed to load the gallery. Please check your connection and try again.',
                ),
              ),
            ),
          );

          verify(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).called(1);
        },
      );

      test(
        'should handle unexpected exceptions and convert to BreedImagesException',
        () async {
          // Arrange
          when(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).thenThrow(Exception('Unexpected error'));

          // Act & Assert
          expect(
            () => repository.getBreedImages(testBreed),
            throwsA(
              isA<BreedImagesException>().having(
                (BreedImagesException e) => e.message,
                'message',
                contains(
                  'An unexpected error occurred while fetching breed images',
                ),
              ),
            ),
          );

          verify(
            () => mockDogApiProvider.getBreedImages(testBreedPath),
          ).called(1);
        },
      );
    });

    group('isBreedCached', () {
      test('should return true when breed is cached', () async {
        // Arrange
        when(
          () => mockCacheDao.isBreedCached(testBreedPath),
        ).thenAnswer((_) async => true);

        // Act
        final bool result = await repository.isBreedCached(testBreed);

        // Assert
        expect(result, isTrue);
        verify(() => mockCacheDao.isBreedCached(testBreedPath)).called(1);
      });

      test('should return false when breed is not cached', () async {
        // Arrange
        when(
          () => mockCacheDao.isBreedCached(testBreedPath),
        ).thenAnswer((_) async => false);

        // Act
        final bool result = await repository.isBreedCached(testBreed);

        // Assert
        expect(result, isFalse);
        verify(() => mockCacheDao.isBreedCached(testBreedPath)).called(1);
      });

      test('should return false when cache check throws exception', () async {
        // Arrange
        when(
          () => mockCacheDao.isBreedCached(testBreedPath),
        ).thenThrow(Exception('Cache error'));

        // Act
        final bool result = await repository.isBreedCached(testBreed);

        // Assert
        expect(result, isFalse);
        verify(() => mockCacheDao.isBreedCached(testBreedPath)).called(1);
      });
    });

    group('getCachedBreedImages', () {
      test('should return cached images when available', () async {
        // Arrange
        when(
          () => mockCacheDao.getCachedImageUrls(testBreedPath),
        ).thenAnswer((_) async => testImageUrls);
        when(
          () => mockIsFavoriteDogUseCase.execute(
            any(),
            onError: any(named: 'onError'),
          ),
        ).thenAnswer((_) => Stream.value(false));

        // Act
        final BreedImagesModel? result = await repository.getCachedBreedImages(
          testBreed,
        );

        // Assert
        expect(result, isNotNull);

        if (result == null) return;

        expect(result.breed, equals(testBreed));
        expect(result.images, hasLength(testImageUrls.length));
        expect(result.images.first.imageUrl, equals(testImageUrls.first));
        expect(result.images.first.isCached, isTrue);

        verify(() => mockCacheDao.getCachedImageUrls(testBreedPath)).called(1);
        verify(
          () => mockIsFavoriteDogUseCase.execute(
            any(),
            onError: any(named: 'onError'),
          ),
        ).called(testImageUrls.length);
      });

      test('should return null when no cached images available', () async {
        // Arrange
        when(
          () => mockCacheDao.getCachedImageUrls(testBreedPath),
        ).thenAnswer((_) async => null);

        // Act
        final BreedImagesModel? result = await repository.getCachedBreedImages(
          testBreed,
        );

        // Assert
        expect(result, isNull);
        verify(() => mockCacheDao.getCachedImageUrls(testBreedPath)).called(1);
      });

      test('should return null when cache throws exception', () async {
        // Arrange
        when(
          () => mockCacheDao.getCachedImageUrls(testBreedPath),
        ).thenThrow(Exception('Cache error'));

        // Act
        final BreedImagesModel? result = await repository.getCachedBreedImages(
          testBreed,
        );

        // Assert
        expect(result, isNull);
        verify(() => mockCacheDao.getCachedImageUrls(testBreedPath)).called(1);
      });
    });

    group('cacheBreedImages', () {
      test('should save images to cache successfully', () async {
        // Arrange
        final BreedImagesModel testModel = BreedImagesModel(
          breed: testBreed,
          images: testImageUrls
              .map(
                (String url) =>
                    BreedImageModel(imageUrl: url, breed: testBreed),
              )
              .toList(),
        );

        const int currentCacheSize = 50 * 1024 * 1024; // 50MB
        const int estimatedSize = 200 * 1024 * 3; // 3 images * 200KB each

        when(
          () => mockCacheDao.getTotalCacheSize(),
        ).thenAnswer((_) async => currentCacheSize);
        when(
          () => mockCacheDao.saveBreedImages(
            breedId: any(named: 'breedId'),
            imageUrls: any(named: 'imageUrls'),
            sizeInBytes: any(named: 'sizeInBytes'),
          ),
        ).thenAnswer((_) async => <dynamic, dynamic>{});

        // Act
        await repository.cacheBreedImages(testModel);

        // Assert
        verify(() => mockCacheDao.getTotalCacheSize()).called(1);
        verify(
          () => mockCacheDao.saveBreedImages(
            breedId: testBreedPath,
            imageUrls: testImageUrls,
            sizeInBytes: estimatedSize,
          ),
        ).called(1);
      });

      test('should evict LRU entries when cache would exceed limit', () async {
        // Arrange
        when(() => mockCacheDao.getTotalCacheSize()).thenAnswer(
          (_) async => BreedImagesRepositoryImpl.maxCacheSizeBytes - 100,
        );
        when(
          () => mockCacheDao.evictLeastRecentlyUsed(any()),
        ).thenAnswer((_) async => 1); // Simulate one entry evicted
        when(
          () => mockCacheDao.saveBreedImages(
            breedId: any(named: 'breedId'),
            imageUrls: any(named: 'imageUrls'),
            sizeInBytes: any(named: 'sizeInBytes'),
          ),
        ).thenAnswer((_) async => <dynamic, dynamic>{});

        final largeImageSet = BreedImagesModel(
          breed: testBreed,
          images: List.generate(
            5,
            (index) => BreedImageModel(
              imageUrl: 'https://example.com/large_image_$index.jpg',
              breed: testBreed,
            ),
          ),
        );

        // Act
        await repository.cacheBreedImages(largeImageSet);

        // Assert
        verify(() => mockCacheDao.getTotalCacheSize()).called(1);
        verify(() => mockCacheDao.evictLeastRecentlyUsed(any())).called(1);
        verify(
          () => mockCacheDao.saveBreedImages(
            breedId: any(named: 'breedId'),
            imageUrls: any(named: 'imageUrls'),
            sizeInBytes: any(named: 'sizeInBytes'),
          ),
        ).called(1);
      });

      test('should not throw when cache operations fail', () async {
        // Arrange
        final BreedImagesModel testModel = BreedImagesModel(
          breed: testBreed,
          images: testImageUrls
              .map(
                (String url) =>
                    BreedImageModel(imageUrl: url, breed: testBreed),
              )
              .toList(),
        );

        when(
          () => mockCacheDao.getTotalCacheSize(),
        ).thenThrow(Exception('Cache error'));

        // Act & Assert
        expect(() => repository.cacheBreedImages(testModel), returnsNormally);
      });
    });

    group('clearCache', () {
      test('should clear all cache successfully', () async {
        // Arrange
        when(
          () => mockCacheDao.clearAllCache(),
        ).thenAnswer((_) async => <dynamic, dynamic>{});

        // Act
        await repository.clearCache();

        // Assert
        verify(() => mockCacheDao.clearAllCache()).called(1);
      });

      test('should throw BreedImagesException when clear fails', () async {
        // Arrange
        when(
          () => mockCacheDao.clearAllCache(),
        ).thenThrow(Exception('Clear error'));

        // Act & Assert
        expect(
          () => repository.clearCache(),
          throwsA(
            isA<BreedImagesException>().having(
              (BreedImagesException e) => e.message,
              'message',
              contains('Failed to clear cache'),
            ),
          ),
        );

        verify(() => mockCacheDao.clearAllCache()).called(1);
      });
    });

    group('getCacheSize', () {
      test('should return cache size when successful', () async {
        // Arrange
        const int expectedSize = 123456;
        when(
          () => mockCacheDao.getTotalCacheSize(),
        ).thenAnswer((_) async => expectedSize);

        // Act
        final int result = await repository.getCacheSize();

        // Assert
        expect(result, equals(expectedSize));
        verify(() => mockCacheDao.getTotalCacheSize()).called(1);
      });

      test('should return 0 when cache size retrieval fails', () async {
        // Arrange
        when(
          () => mockCacheDao.getTotalCacheSize(),
        ).thenThrow(Exception('Cache error'));

        // Act
        final int result = await repository.getCacheSize();

        // Assert
        expect(result, equals(0));
        verify(() => mockCacheDao.getTotalCacheSize()).called(1);
      });
    });
  });
}
