import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pawsitive_vibe_finder/src/domain/domain.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRandomDogUseCase _getRandomDogUseCase;
  final CheckFirstLaunchUseCase _checkFirstLaunchUseCase;
  final SetFirstLaunchCompletedUseCase _setFirstLaunchCompletedUseCase;
  final SaveFavoriteDogUseCase _saveFavoriteDogUseCase;

  HomeBloc({
    required GetRandomDogUseCase getRandomDogUseCase,
    required CheckFirstLaunchUseCase checkFirstLaunchUseCase,
    required SetFirstLaunchCompletedUseCase setFirstLaunchCompletedUseCase,
    required SaveFavoriteDogUseCase saveFavoriteDogUseCase,
  }) : _getRandomDogUseCase = getRandomDogUseCase,
       _checkFirstLaunchUseCase = checkFirstLaunchUseCase,
       _setFirstLaunchCompletedUseCase = setFirstLaunchCompletedUseCase,
       _saveFavoriteDogUseCase = saveFavoriteDogUseCase,
       super(HomeInitial()) {
    on<LoadHomeEvent>(_onLoadHome);
    on<CompleteFirstLaunchEvent>(_onCompleteFirstLaunch);
    on<SwipeLeftEvent>(_onSwipeLeft);
    on<SwipeRightEvent>(_onSwipeRight);
  }

  Future<void> _onLoadHome(LoadHomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final isFirstLaunch = await _checkFirstLaunchUseCase.executeOrNull(null);
      if (isFirstLaunch == true) {
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
    await _fetchRandomDog(emit);
  }

  Future<void> _onSwipeRight(
    SwipeRightEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      // First, save the current dog as a favorite.
      await _saveFavoriteDogUseCase.executeOrNull(event.dog);
      // Then, fetch the next dog.
      await _fetchRandomDog(emit);
    } on AppException catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  /// Helper method to fetch a random dog and emit the appropriate state.
  Future<void> _fetchRandomDog(Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final dog = await _getRandomDogUseCase.executeOrNull(null);
      if (dog != null) {
        emit(SubsequentLaunchState(imageUrl: dog.imageUrl, breed: dog.breed));
      } else {
        emit(const HomeError(message: 'Could not fetch a new dog.'));
      }
    } on AppException catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
