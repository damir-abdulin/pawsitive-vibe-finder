import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/domain.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRandomDogsUseCase _getRandomDogsUseCase;
  final CheckFirstLaunchUseCase _checkFirstLaunchUseCase;
  final SetFirstLaunchCompletedUseCase _setFirstLaunchCompletedUseCase;
  final SaveFavoriteDogUseCase _saveFavoriteDogUseCase;
  final SaveLastDogUseCase _saveLastDogUseCase;
  final GetLastDogUseCase _getLastDogUseCase;

  static const int _maxDogCount = 30;
  static const int _minDogThreshold = 12;
  static const int _fetchDogCount = 3;

  HomeBloc({
    required GetRandomDogsUseCase getRandomDogsUseCase,
    required CheckFirstLaunchUseCase checkFirstLaunchUseCase,
    required SetFirstLaunchCompletedUseCase setFirstLaunchCompletedUseCase,
    required SaveFavoriteDogUseCase saveFavoriteDogUseCase,
    required SaveLastDogUseCase saveLastDogUseCase,
    required GetLastDogUseCase getLastDogUseCase,
  }) : _getRandomDogsUseCase = getRandomDogsUseCase,
       _checkFirstLaunchUseCase = checkFirstLaunchUseCase,
       _setFirstLaunchCompletedUseCase = setFirstLaunchCompletedUseCase,
       _saveFavoriteDogUseCase = saveFavoriteDogUseCase,
       _saveLastDogUseCase = saveLastDogUseCase,
       _getLastDogUseCase = getLastDogUseCase,
       super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHome);
    on<CompleteFirstLaunchEvent>(_onCompleteFirstLaunch);
    on<SwipeLeftEvent>(_onSwipeLeft);
    on<SwipeRightEvent>(_onSwipeRight);
  }

  Future<void> _onLoadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final bool? isFirstLaunch = await _checkFirstLaunchUseCase.executeOrNull(
        null,
      );
      if (isFirstLaunch ?? true) {
        emit(FirstLaunchState());
      } else {
        await _fetchRandomDog(emit);
      }
    } on AppException catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onCompleteFirstLaunch(
    CompleteFirstLaunchEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      await _setFirstLaunchCompletedUseCase.executeOrNull(null);
      // Per requirements, no image is shown after first launch welcome.
      // The user will see the empty state of the home page.
      emit(HomeInitial());
    } on AppException catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onSwipeLeft(
    SwipeLeftEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _handleSwipe(event.dog, emit, isFavorite: false);
  }

  Future<void> _onSwipeRight(
    SwipeRightEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _handleSwipe(event.dog, emit, isFavorite: true);
  }

  Future<void> _handleSwipe(
    RandomDogModel dog,
    Emitter<HomeState> emit, {
    required bool isFavorite,
  }) async {
    if (state is! SubsequentLaunchState) {
      return;
    }

    if (isFavorite) {
      await _saveFavoriteDogUseCase.executeOrNull(dog);
    }

    final List<RandomDogModel> dogs =
        (state as SubsequentLaunchState).dogs.toList()..removeAt(0);

    if (dogs.isEmpty) {
      await _fetchRandomDog(emit, currentDogs: dogs);
    } else {
      emit(SubsequentLaunchState(dogs: dogs));

      if (dogs.length <= _minDogThreshold) {
        await _fetchRandomDog(emit, currentDogs: dogs);
      }
    }
  }

  /// Helper method to fetch a random dog and emit the appropriate state.
  Future<void> _fetchRandomDog(
    Emitter<HomeState> emit, {
    List<RandomDogModel> currentDogs = const <RandomDogModel>[],
  }) async {
    if (currentDogs.length >= _maxDogCount) {
      return;
    }

    try {
      final List<RandomDogModel>? newDogs = await _getRandomDogsUseCase
          .executeOrNull(_fetchDogCount);
      if (newDogs != null && newDogs.isNotEmpty) {
        await _saveLastDogUseCase.executeOrNull(newDogs.first);
        final List<RandomDogModel> updatedDogs = <RandomDogModel>[
          ...currentDogs,
          ...newDogs,
        ];
        emit(SubsequentLaunchState(dogs: updatedDogs));
      } else if (currentDogs.isEmpty) {
        final RandomDogModel? cachedDog = await _getLastDogUseCase
            .executeOrNull(null);
        if (cachedDog != null) {
          emit(SubsequentLaunchState(dogs: <RandomDogModel>[cachedDog]));
        } else {
          emit(const HomeError(message: 'Could not fetch a new dog.'));
        }
      }
    } on AppException catch (e) {
      if (currentDogs.isEmpty) {
        final RandomDogModel? cachedDog = await _getLastDogUseCase
            .executeOrNull(null);
        if (cachedDog != null) {
          emit(SubsequentLaunchState(dogs: <RandomDogModel>[cachedDog]));
        } else {
          emit(HomeError(message: e.toString()));
        }
      }
    }
  }
}
