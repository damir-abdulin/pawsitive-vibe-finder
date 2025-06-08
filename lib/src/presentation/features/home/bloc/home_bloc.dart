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

  final BreedType? _breed;

  HomeBloc({
    required GetRandomDogsUseCase getRandomDogsUseCase,
    required CheckFirstLaunchUseCase checkFirstLaunchUseCase,
    required SetFirstLaunchCompletedUseCase setFirstLaunchCompletedUseCase,
    required SaveFavoriteDogUseCase saveFavoriteDogUseCase,
    required SaveLastDogUseCase saveLastDogUseCase,
    required GetLastDogUseCase getLastDogUseCase,
    required BreedType? breed,
  }) : _getRandomDogsUseCase = getRandomDogsUseCase,
       _checkFirstLaunchUseCase = checkFirstLaunchUseCase,
       _setFirstLaunchCompletedUseCase = setFirstLaunchCompletedUseCase,
       _saveFavoriteDogUseCase = saveFavoriteDogUseCase,
       _saveLastDogUseCase = saveLastDogUseCase,
       _getLastDogUseCase = getLastDogUseCase,
       _breed = breed,
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
    DogModel dog,
    Emitter<HomeState> emit, {
    required bool isFavorite,
  }) async {
    if (state is! SubsequentLaunchState) {
      return;
    }

    if (isFavorite) {
      await _saveFavoriteDogUseCase.executeOrNull(dog);
    }

    final List<DogModel> dogs = (state as SubsequentLaunchState).dogs.toList()
      ..removeAt(0);

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
    List<DogModel> currentDogs = const <DogModel>[],
  }) async {
    if (currentDogs.length >= _maxDogCount) {
      return;
    }

    try {
      final List<DogModel>? newDogs = await _getRandomDogsUseCase.executeOrNull(
        (_fetchDogCount, _breed),
      );
      if (newDogs != null && newDogs.isNotEmpty) {
        await _saveLastDogUseCase.executeOrNull(newDogs.first);
        final List<DogModel> updatedDogs = <DogModel>[
          ...currentDogs,
          ...newDogs,
        ];
        emit(SubsequentLaunchState(dogs: updatedDogs));
      } else if (currentDogs.isEmpty) {
        final DogModel? cachedDog = await _getLastDogUseCase.executeOrNull(
          null,
        );
        if (cachedDog != null) {
          emit(SubsequentLaunchState(dogs: <DogModel>[cachedDog]));
        } else {
          emit(const HomeError(message: 'Could not fetch a new dog.'));
        }
      }
    } on AppException catch (e) {
      if (currentDogs.isEmpty) {
        final DogModel? cachedDog = await _getLastDogUseCase.executeOrNull(
          null,
        );
        if (cachedDog != null) {
          emit(SubsequentLaunchState(dogs: <DogModel>[cachedDog]));
        } else {
          emit(HomeError(message: e.toString()));
        }
      }
    }
  }
}
