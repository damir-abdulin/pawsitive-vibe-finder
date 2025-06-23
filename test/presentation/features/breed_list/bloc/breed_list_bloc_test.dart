// ignore_for_file: avoid-late-keyword

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:pawsitive_vibe_finder/src/domain/domain.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/breed_list/bloc/breed_list_bloc.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/breed_list/bloc/breed_list_event.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/breed_list/bloc/breed_list_state.dart';

/// Mock класс для [GetBreedsUseCase]
class MockGetBreedsUseCase extends Mock implements GetBreedsUseCase {}

void main() {
  group('BreedListBloc', () {
    // Arrange - Подготавливаем общие объекты для всех тестов
    late MockGetBreedsUseCase mockGetBreedsUseCase;
    late BreedListBloc breedListBloc;

    setUp(() {
      mockGetBreedsUseCase = MockGetBreedsUseCase();
      breedListBloc = BreedListBloc(getBreedsUseCase: mockGetBreedsUseCase);
    });

    tearDown(() {
      breedListBloc.close();
    });

    test(
      'начальное состояние должно быть BreedListState с initial статусом',
      () {
        // Assert - Проверяем начальное состояние
        expect(breedListBloc.state, equals(const BreedListState()));
        expect(breedListBloc.state.status, equals(BreedListStatus.initial));
        expect(breedListBloc.state.breeds, isEmpty);
        expect(breedListBloc.state.filteredBreeds, isEmpty);
        expect(breedListBloc.state.errorMessage, isNull);
      },
    );

    group('BreedListFetchRequested', () {
      blocTest<BreedListBloc, BreedListState>(
        'должен эмитить [loading, success] при успешном получении пород',
        build: () {
          // Arrange - Настраиваем мок для успешного результата
          const List<BreedType> expectedBreeds = <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.labrador,
            BreedType.pug,
          ];

          when(
            () => mockGetBreedsUseCase.unsafeExecute(any()),
          ).thenAnswer((_) async => expectedBreeds);

          return breedListBloc;
        },
        act: (BreedListBloc bloc) => bloc.add(BreedListFetchRequested()),
        expect: () => <BreedListState>[
          // Первое состояние - loading
          const BreedListState(status: BreedListStatus.loading),
          // Второе состояние - success с данными
          const BreedListState(
            status: BreedListStatus.success,
            breeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
              BreedType.pug,
            ],
            filteredBreeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
              BreedType.pug,
            ],
          ),
        ],
        verify: (_) {
          // Проверяем, что use case был вызван один раз
          verify(() => mockGetBreedsUseCase.unsafeExecute(null)).called(1);
        },
      );

      blocTest<BreedListBloc, BreedListState>(
        'должен эмитить [loading, success] с пустым списком при получении пустого результата',
        build: () {
          // Arrange - Настраиваем мок для пустого результата
          when(
            () => mockGetBreedsUseCase.unsafeExecute(any()),
          ).thenAnswer((_) async => <BreedType>[]);

          return breedListBloc;
        },
        act: (BreedListBloc bloc) => bloc.add(BreedListFetchRequested()),
        expect: () => <BreedListState>[
          // Первое состояние - loading
          const BreedListState(status: BreedListStatus.loading),
          // Второе состояние - success с пустыми списками
          const BreedListState(status: BreedListStatus.success),
        ],
        verify: (_) {
          verify(() => mockGetBreedsUseCase.unsafeExecute(null)).called(1);
        },
      );

      blocTest<BreedListBloc, BreedListState>(
        'должен эмитить [loading, failure] при выбросе исключения use case',
        build: () {
          // Arrange - Настраиваем мок для выброса исключения
          const BreedException expectedException = BreedException(
            message: 'Failed to fetch breeds from API',
          );

          when(
            () => mockGetBreedsUseCase.unsafeExecute(any()),
          ).thenThrow(expectedException);

          return breedListBloc;
        },
        act: (BreedListBloc bloc) => bloc.add(BreedListFetchRequested()),
        expect: () => <BreedListState>[
          // Первое состояние - loading
          const BreedListState(status: BreedListStatus.loading),
          // Второе состояние - failure с сообщением об ошибке
          const BreedListState(
            status: BreedListStatus.failure,
            errorMessage: "Instance of 'BreedException'",
          ),
        ],
        verify: (_) {
          verify(() => mockGetBreedsUseCase.unsafeExecute(null)).called(1);
        },
      );

      blocTest<BreedListBloc, BreedListState>(
        'должен эмитить [loading, failure] при любом другом исключении',
        build: () {
          // Arrange - Настраиваем мок для выброса общего исключения
          when(
            () => mockGetBreedsUseCase.unsafeExecute(any()),
          ).thenThrow(Exception('Network error'));

          return breedListBloc;
        },
        act: (BreedListBloc bloc) => bloc.add(BreedListFetchRequested()),
        expect: () => <BreedListState>[
          const BreedListState(status: BreedListStatus.loading),
          const BreedListState(
            status: BreedListStatus.failure,
            errorMessage: 'Exception: Network error',
          ),
        ],
        verify: (_) {
          verify(() => mockGetBreedsUseCase.unsafeExecute(null)).called(1);
        },
      );
    });

    group('BreedListSearchChanged', () {
      blocTest<BreedListBloc, BreedListState>(
        'должен фильтровать породы по поисковому запросу (регистронезависимо)',
        build: () => breedListBloc,
        seed: () => const BreedListState(
          status: BreedListStatus.success,
          breeds: <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.labrador,
            BreedType.pug,
            BreedType.germanshepherd,
          ],
          filteredBreeds: <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.labrador,
            BreedType.pug,
            BreedType.germanshepherd,
          ],
        ),
        act: (BreedListBloc bloc) =>
            bloc.add(const BreedListSearchChanged('lab')),
        expect: () => <BreedListState>[
          const BreedListState(
            status: BreedListStatus.success,
            breeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
              BreedType.pug,
              BreedType.germanshepherd,
            ],
            filteredBreeds: <BreedType>[
              BreedType.labrador,
            ], // Только labrador содержит 'lab'
          ),
        ],
      );

      blocTest<BreedListBloc, BreedListState>(
        'должен фильтровать породы по поисковому запросу в верхнем регистре',
        build: () => breedListBloc,
        seed: () => const BreedListState(
          status: BreedListStatus.success,
          breeds: <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.germanshepherd,
          ],
          filteredBreeds: <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.germanshepherd,
          ],
        ),
        act: (BreedListBloc bloc) =>
            bloc.add(const BreedListSearchChanged('GERMAN')),
        expect: () => <BreedListState>[
          const BreedListState(
            status: BreedListStatus.success,
            breeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.germanshepherd,
            ],
            filteredBreeds: <BreedType>[BreedType.germanshepherd],
          ),
        ],
      );

      blocTest<BreedListBloc, BreedListState>(
        'должен показать все породы при пустом поисковом запросе',
        build: () => breedListBloc,
        seed: () => const BreedListState(
          status: BreedListStatus.success,
          breeds: <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.labrador,
          ],
          filteredBreeds: <BreedType>[BreedType.beagle], // Предыдущий фильтр
        ),
        act: (BreedListBloc bloc) => bloc.add(const BreedListSearchChanged('')),
        expect: () => <BreedListState>[
          const BreedListState(
            status: BreedListStatus.success,
            breeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
            ],
            filteredBreeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
            ], // Все породы отображаются снова
          ),
        ],
      );

      blocTest<BreedListBloc, BreedListState>(
        'должен показать пустой список при поиске несуществующей породы',
        build: () => breedListBloc,
        seed: () => const BreedListState(
          status: BreedListStatus.success,
          breeds: <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.labrador,
          ],
          filteredBreeds: <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.labrador,
          ],
        ),
        act: (BreedListBloc bloc) =>
            bloc.add(const BreedListSearchChanged('nonexistent')),
        expect: () => <BreedListState>[
          const BreedListState(
            status: BreedListStatus.success,
            breeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
            ],
          ),
        ],
      );
    });

    group('Интеграционные тесты событий', () {
      blocTest<BreedListBloc, BreedListState>(
        'должен загрузить породы и затем правильно фильтровать их',
        build: () {
          // Arrange - Настраиваем мок
          const List<BreedType> allBreeds = <BreedType>[
            BreedType.affenpinscher,
            BreedType.beagle,
            BreedType.labrador,
            BreedType.pug,
          ];

          when(
            () => mockGetBreedsUseCase.unsafeExecute(any()),
          ).thenAnswer((_) async => allBreeds);

          return breedListBloc;
        },
        act: (BreedListBloc bloc) async {
          // Act - Последовательность действий: загрузка + поиск
          bloc.add(BreedListFetchRequested());
          await Future<void>.delayed(const Duration(milliseconds: 10));
          bloc.add(const BreedListSearchChanged('be'));
        },
        expect: () => <BreedListState>[
          // Загрузка
          const BreedListState(status: BreedListStatus.loading),
          // Успешная загрузка
          const BreedListState(
            status: BreedListStatus.success,
            breeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
              BreedType.pug,
            ],
            filteredBreeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
              BreedType.pug,
            ],
          ),
          // Фильтрация по 'be' (beagle содержит 'be')
          const BreedListState(
            status: BreedListStatus.success,
            breeds: <BreedType>[
              BreedType.affenpinscher,
              BreedType.beagle,
              BreedType.labrador,
              BreedType.pug,
            ],
            filteredBreeds: <BreedType>[BreedType.beagle],
          ),
        ],
        verify: (_) {
          verify(() => mockGetBreedsUseCase.unsafeExecute(null)).called(1);
        },
      );
    });
  });
}
