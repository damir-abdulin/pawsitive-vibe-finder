part of 'favorites_bloc.dart';

/// Base class for all states related to the favorites feature.
///
/// The UI will react to these states to display the appropriate information.
abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => <Object>[];
}

/// The initial state of the favorites screen.
class FavoritesInitial extends FavoritesState {}

/// The state indicating that the list of favorite dogs is being loaded.
class FavoritesLoadInProgress extends FavoritesState {}

/// The state indicating that the list of favorite dogs has been successfully
/// loaded.
class FavoritesLoadSuccess extends FavoritesState {
  /// The list of favorite dogs.
  final List<DogModel> favoriteDogs;

  /// Creates a [FavoritesLoadSuccess] state.
  const FavoritesLoadSuccess({required this.favoriteDogs});

  @override
  List<Object> get props => <Object>[favoriteDogs];
}

/// The state indicating that the favorites list is empty.
class FavoritesEmpty extends FavoritesState {}

/// The state indicating that an error occurred while loading favorite dogs.
class FavoritesLoadFailure extends FavoritesState {
  /// The error message.
  final String message;

  /// Creates a [FavoritesLoadFailure] state.
  const FavoritesLoadFailure({required this.message});

  @override
  List<Object> get props => <Object>[message];
}
