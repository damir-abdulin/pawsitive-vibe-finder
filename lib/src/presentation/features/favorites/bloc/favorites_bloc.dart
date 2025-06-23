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
    on<FavoritesRefreshed>(_onFavoritesRefreshed);
  }

  Future<void> _onFavoritesStarted(
    FavoritesStarted event,
    Emitter<FavoritesState> emit,
  ) async {
    await _fetchAndEmitFavorites(emit);
  }

  Future<void> _onFavoritesRefreshed(
    FavoritesRefreshed event,
    Emitter<FavoritesState> emit,
  ) async {
    await _fetchAndEmitFavorites(emit);
  }

  Future<void> _fetchAndEmitFavorites(Emitter<FavoritesState> emit) async {
    emit(FavoritesLoadInProgress());
    try {
      final List<DogModel> dogs = await _getFavoriteDogsUseCase
          .execute(null)
          .first;
      if (dogs.isEmpty) {
        emit(FavoritesEmpty());
      } else {
        emit(FavoritesLoadSuccess(favoriteDogs: dogs));
      }
    } catch (error) {
      emit(FavoritesLoadFailure(message: error.toString()));
    }
  }

  Future<void> _onFavoriteDogRemoved(
    FavoriteDogRemoved event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _removeFavoriteDogUseCase.execute(event.dog);
    } catch (_) {
      // Handle error gracefully, maybe log it.
      // For now, we don't emit a state to avoid disrupting the UI.
    }
  }

  Future<void> _onFavoriteDogAdded(
    FavoriteDogAdded event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _saveFavoriteDogUseCase.execute(event.dog);
    } catch (_) {
      // Handle error gracefully, maybe log it.
    }
  }
}
