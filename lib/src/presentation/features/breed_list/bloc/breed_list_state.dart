import 'package:equatable/equatable.dart';

import '../../../../domain/models/breed_type.dart';

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
  final List<BreedType> breeds;

  /// The filtered list of breeds.
  final List<BreedType> filteredBreeds;

  /// The error message, if any.
  final String? errorMessage;

  /// Creates a [BreedListState].
  const BreedListState({
    this.status = BreedListStatus.initial,
    this.breeds = const <BreedType>[],
    this.filteredBreeds = const <BreedType>[],
    this.errorMessage,
  });

  /// Creates a copy of this state with the given fields replaced.
  BreedListState copyWith({
    BreedListStatus? status,
    List<BreedType>? breeds,
    List<BreedType>? filteredBreeds,
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
  List<Object?> get props => <Object?>[
    status,
    breeds,
    filteredBreeds,
    errorMessage,
  ];
}
