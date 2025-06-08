import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/domain.dart';

part 'dog_details_event.dart';
part 'dog_details_state.dart';

class DogDetailsBloc extends Bloc<DogDetailsEvent, DogDetailsState> {
  final IsFavoriteDogUseCase _isFavoriteDogUseCase;
  final SaveFavoriteDogUseCase _saveFavoriteDogUseCase;
  final RemoveFavoriteDogUseCase _removeFavoriteDogUseCase;
  final DogModel _dog;

  DogDetailsBloc({
    required IsFavoriteDogUseCase isFavoriteDogUseCase,
    required SaveFavoriteDogUseCase saveFavoriteDogUseCase,
    required RemoveFavoriteDogUseCase removeFavoriteDogUseCase,
    required DogModel dog,
  }) : _isFavoriteDogUseCase = isFavoriteDogUseCase,
       _saveFavoriteDogUseCase = saveFavoriteDogUseCase,
       _removeFavoriteDogUseCase = removeFavoriteDogUseCase,
       _dog = dog,
       super(DogDetailsInitial()) {
    on<DogDetailsStarted>(_onStarted);
    on<DogDetailsFavoriteToggled>(_onFavoriteToggled);
  }

  Future<void> _onStarted(
    DogDetailsStarted event,
    Emitter<DogDetailsState> emit,
  ) async {
    emit(DogDetailsLoadInProgress());
    final bool isFavorite = await _isFavoriteDogUseCase.execute(_dog);
    emit(DogDetailsLoadSuccess(isFavorite: isFavorite));
  }

  Future<void> _onFavoriteToggled(
    DogDetailsFavoriteToggled event,
    Emitter<DogDetailsState> emit,
  ) async {
    if (state is! DogDetailsLoadSuccess) return;

    final DogDetailsLoadSuccess currentState = state as DogDetailsLoadSuccess;
    final bool isCurrentlyFavorite = currentState.isFavorite;

    emit(
      currentState.copyWith(isFavorite: !isCurrentlyFavorite, wasToggled: true),
    );

    if (isCurrentlyFavorite) {
      await _removeFavoriteDogUseCase.execute(_dog);
    } else {
      await _saveFavoriteDogUseCase.execute(_dog);
    }
  }
}
