// ignore_for_file: avoid-late-keyword

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pawsitive_vibe_finder/src/domain/domain.dart';

class MockBreedRepository extends Mock implements BreedRepository {}

void main() {
  late GetBreedsUseCase getBreedsUseCase;
  late MockBreedRepository mockBreedRepository;

  setUp(() {
    mockBreedRepository = MockBreedRepository();
    getBreedsUseCase = GetBreedsUseCase(breedRepository: mockBreedRepository);
  });

  group('GetBreedsUseCase', () {
    group('unsafeExecute', () {
      test('should return a list of breeds on successful execution', () async {
        // Arrange
        const expectedBreeds = <BreedType>[
          BreedType.affenpinscher,
          BreedType.beagle,
          BreedType.boxer,
          BreedType.labrador,
          BreedType.pug,
        ];
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenAnswer((_) async => expectedBreeds);

        // Act
        final actualBreeds = await getBreedsUseCase.unsafeExecute(null);

        // Assert
        expect(actualBreeds, equals(expectedBreeds));
        expect(actualBreeds, hasLength(5));
        expect(actualBreeds.first, equals(BreedType.affenpinscher));
        expect(actualBreeds.last, equals(BreedType.pug));
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });

      test('should return an empty list if no breeds are available', () async {
        // Arrange
        const expectedBreeds = <BreedType>[];
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenAnswer((_) async => expectedBreeds);

        // Act
        final actualBreeds = await getBreedsUseCase.unsafeExecute(null);

        // Assert
        expect(actualBreeds, equals(expectedBreeds));
        expect(actualBreeds, isEmpty);
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });

      test('should rethrow BreedException from the repository', () async {
        // Arrange
        final expectedException = const BreedException(
          message: 'Failed to fetch breeds from API',
        );
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenThrow(expectedException);

        // Act & Assert
        expect(
          () => getBreedsUseCase.unsafeExecute(null),
          throwsA(
            isA<BreedException>().having(
              (e) => e.message,
              'message',
              contains('Failed to fetch breeds'),
            ),
          ),
        );
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });
    });

    group('execute', () {
      test('should execute successfully without an error handler', () async {
        // Arrange
        const expectedBreeds = <BreedType>[
          BreedType.germanshepherd,
          BreedType.husky,
        ];
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenAnswer((_) async => expectedBreeds);

        // Act
        final actualBreeds = await getBreedsUseCase.execute(null);

        // Assert
        expect(actualBreeds, equals(expectedBreeds));
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });

      test('should handle error using the onError callback', () async {
        // Arrange
        final originalException = const BreedException(
          message: 'Network error',
        );
        const fallbackBreeds = <BreedType>[BreedType.mix];
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenThrow(originalException);

        // Act
        final actualBreeds = await getBreedsUseCase.execute(
          null,
          onError: (exception) async {
            expect(exception, isA<BreedException>());
            expect(exception.message, contains('Network error'));
            return fallbackBreeds;
          },
        );

        // Assert
        expect(actualBreeds, equals(fallbackBreeds));
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });

      test('should rethrow exception if onError is not provided', () async {
        // Arrange
        final expectedException = const BreedException(
          message: 'Repository failure',
        );
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenThrow(expectedException);

        // Act & Assert
        expect(
          () => getBreedsUseCase.execute(null),
          throwsA(
            isA<BreedException>().having(
              (e) => e.message,
              'message',
              contains('Repository failure'),
            ),
          ),
        );
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });
    });

    group('executeOrNull', () {
      test('should return a result on successful execution', () async {
        // Arrange
        const expectedBreeds = <BreedType>[BreedType.husky, BreedType.malamute];
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenAnswer((_) async => expectedBreeds);

        // Act
        final actualBreeds = await getBreedsUseCase.executeOrNull(null);

        // Assert
        expect(actualBreeds, equals(expectedBreeds));
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });

      test('should return null when an AppException is thrown', () async {
        // Arrange
        final expectedException = const BreedException(
          message: 'Some domain error',
        );
        when(
          () => mockBreedRepository.getBreeds(),
        ).thenThrow(expectedException);

        // Act
        final result = await getBreedsUseCase.executeOrNull(null);

        // Assert
        expect(result, isNull);
        verify(() => mockBreedRepository.getBreeds()).called(1);
      });
    });
  });
}
