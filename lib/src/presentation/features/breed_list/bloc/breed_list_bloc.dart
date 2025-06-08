import 'package:bloc/bloc.dart';

import '../../../../domain/models/breed_model.dart';
import '../../../../domain/use_case/get_breeds_use_case.dart';
import 'breed_list_event.dart';
import 'breed_list_state.dart';

/// The BLoC for the breed list screen.
class BreedListBloc extends Bloc<BreedListEvent, BreedListState> {
  final GetBreedsUseCase _getBreedsUseCase;

  /// Creates a [BreedListBloc].
  BreedListBloc({required GetBreedsUseCase getBreedsUseCase})
    : _getBreedsUseCase = getBreedsUseCase,
      super(const BreedListState()) {
    on<BreedListFetchRequested>(_onFetchRequested);
    on<BreedListSearchChanged>(_onSearchChanged);
  }

  Future<void> _onFetchRequested(
    BreedListFetchRequested event,
    Emitter<BreedListState> emit,
  ) async {
    emit(state.copyWith(status: BreedListStatus.loading));
    try {
      final List<BreedModel> breeds = await _getBreedsUseCase.unsafeExecute(null);
      emit(
        state.copyWith(
          status: BreedListStatus.success,
          breeds: breeds,
          filteredBreeds: breeds,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: BreedListStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onSearchChanged(
    BreedListSearchChanged event,
    Emitter<BreedListState> emit,
  ) {
    final String query = event.query.toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(filteredBreeds: state.breeds));
    } else {
      final List<BreedModel> filtered = state.breeds
          .where((BreedModel breed) => breed.displayName.toLowerCase().contains(query))
          .toList();
      emit(state.copyWith(filteredBreeds: filtered));
    }
  }
}
