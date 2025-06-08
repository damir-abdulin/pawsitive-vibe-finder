import 'package:equatable/equatable.dart';

import '../../../../domain/breed/models/breed_model.dart';

/// The status of the breed list.
enum BreedListStatus {
  /// The initial state.
  initial,

  /// The loading state.
  loading,

  /// The success state.
  success,

  /// The failure state.
  failure,
}

/// The state of the breed list screen.
class BreedListState extends Equatable {
  /// The status of the breed list.
  final BreedListStatus status;

  /// The list of all breeds.
  final List<BreedModel> breeds;

  /// The filtered list of breeds.
  final List<BreedModel> filteredBreeds;

  /// The error message, if any.
  final String? errorMessage;

  /// Creates a [BreedListState].
  const BreedListState({
    this.status = BreedListStatus.initial,
    this.breeds = const <BreedModel>[],
    this.filteredBreeds = const <BreedModel>[],
    this.errorMessage,
  });

  /// Creates a copy of this state with the given fields replaced.
  BreedListState copyWith({
    BreedListStatus? status,
    List<BreedModel>? breeds,
    List<BreedModel>? filteredBreeds,
    String? errorMessage,
  }) {
    return BreedListState(
      status: status ?? this.status,
      breeds: breeds ?? this.breeds,
      filteredBreeds: filteredBreeds ?? this.filteredBreeds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, breeds, filteredBreeds, errorMessage];
}
