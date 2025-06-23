// ignore_for_file: avoid-late-keyword, no-empty-block

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pawsitive_vibe_finder/src/domain/domain.dart';

/// Mock class for [BreedImagesRepository]
class MockBreedImagesRepository extends Mock implements BreedImagesRepository {}

/// Mock class for [ConnectivityService]
class MockConnectivityService extends Mock implements ConnectivityService {}

class FakeGetBreedImagesInput extends Fake implements GetBreedImagesInput {}

class FakeBreedImagesModel extends Fake implements BreedImagesModel {}

void main() {
  late GetBreedImagesUseCase useCase;
  late MockBreedImagesRepository mockBreedImagesRepository;
  late MockConnectivityService mockConnectivityService;

  setUpAll(() {
    registerFallbackValue(FakeGetBreedImagesInput());
    registerFallbackValue(FakeBreedImagesModel());
    registerFallbackValue(BreedType.mix);
  });

  setUp(() {
    mockBreedImagesRepository = MockBreedImagesRepository();
    mockConnectivityService = MockConnectivityService();
    useCase = GetBreedImagesUseCase(
      breedImagesRepository: mockBreedImagesRepository,
      connectivityService: mockConnectivityService,
    );
  });

  const testBreed = BreedType.pug;
  final inputParams = GetBreedImagesInput(breed: testBreed);

  group('GetBreedImagesUseCase', () {
    test('online mode test', () async {
      // Arrange
      when(
        () => mockConnectivityService.isConnected(),
      ).thenAnswer((_) async => true);
      when(() => mockBreedImagesRepository.getBreedImages(any())).thenAnswer(
        (_) async => BreedImagesModel(breed: testBreed, images: const []),
      );
      when(
        () => mockBreedImagesRepository.cacheBreedImages(any()),
      ).thenAnswer((_) async {});

      // Act
      await useCase.unsafeExecute(inputParams);

      // Assert
      verify(
        () => mockBreedImagesRepository.getBreedImages(testBreed),
      ).called(1);
    });

    test('offline mode with cache test', () async {
      // Arrange
      when(
        () => mockConnectivityService.isConnected(),
      ).thenAnswer((_) async => false);
      when(
        () => mockBreedImagesRepository.getCachedBreedImages(any()),
      ).thenAnswer(
        (_) async => BreedImagesModel(breed: testBreed, images: const []),
      );

      // Act
      await useCase.unsafeExecute(inputParams);

      // Assert
      verify(
        () => mockBreedImagesRepository.getCachedBreedImages(testBreed),
      ).called(1);
    });

    test('offline mode with no cache should throw', () async {
      // Arrange
      when(
        () => mockConnectivityService.isConnected(),
      ).thenAnswer((_) async => false);
      when(
        () => mockBreedImagesRepository.getCachedBreedImages(any()),
      ).thenAnswer((_) async => null);

      // Act & Assert
      expect(
        () => useCase.unsafeExecute(inputParams),
        throwsA(isA<BreedImagesException>()),
      );
    });
  });
}
