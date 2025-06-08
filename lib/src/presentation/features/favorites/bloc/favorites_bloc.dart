import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/domain.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

/// BLoC for the favorites feature.
///
/// This class manages the state of the favorites screen, handling events
/// such as loading favorite dogs and modifying the favorites list.
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final GetFavoriteDogsUseCase _getFavoriteDogsUseCase;
  final SaveFavoriteDogUseCase _saveFavoriteDogUseCase;
  final RemoveFavoriteDogUseCase _removeFavoriteDogUseCase;
  StreamSubscription<List<DogModel>>? _favoritesSubscription;

  /// Creates a [FavoritesBloc] instance.
  ///
  /// Requires use cases for getting, saving, and removing favorite dogs.
  FavoritesBloc({
    required GetFavoriteDogsUseCase getFavoriteDogsUseCase,
    required SaveFavoriteDogUseCase saveFavoriteDogUseCase,
    required RemoveFavoriteDogUseCase removeFavoriteDogUseCase,
  }) : _getFavoriteDogsUseCase = getFavoriteDogsUseCase,
       _saveFavoriteDogUseCase = saveFavoriteDogUseCase,
       _removeFavoriteDogUseCase = removeFavoriteDogUseCase,
       super(FavoritesInitial()) {
    on<FavoritesStarted>(_onFavoritesStarted);
    on<FavoriteDogRemoved>(_onFavoriteDogRemoved);
    on<FavoriteDogAdded>(_onFavoriteDogAdded);
    on<_UpdateDogs>(_onUpdateDogs);
  }

  @override
  Future<void> close() {
    _favoritesSubscription?.cancel();
    return super.close();
  }

  void _onFavoritesStarted(
    FavoritesStarted event,
    Emitter<FavoritesState> emit,
  ) {
    emit(FavoritesLoadInProgress());
    _favoritesSubscription?.cancel();
    _favoritesSubscription = _getFavoriteDogsUseCase.execute(null).listen(
      (List<DogModel> dogs) {
        add(_UpdateDogs(dogs: dogs));
      },
      onError: (Object error) =>
          emit(FavoritesLoadFailure(message: error.toString())),
    );
  }

  Future<void> _onFavoriteDogRemoved(
    FavoriteDogRemoved event,
    Emitter<FavoritesState> emit,
  ) async {
    await _removeFavoriteDogUseCase.execute(event.dog);
  }

  Future<void> _onFavoriteDogAdded(
    FavoriteDogAdded event,
    Emitter<FavoritesState> emit,
  ) async {
    await _saveFavoriteDogUseCase.execute(event.dog);
  }

  void _onUpdateDogs(_UpdateDogs event, Emitter<FavoritesState> emit) {
    if (event.dogs.isEmpty) {
      emit(FavoritesEmpty());
    } else {
      emit(FavoritesLoadSuccess(favoriteDogs: event.dogs));
    }
  }
}
