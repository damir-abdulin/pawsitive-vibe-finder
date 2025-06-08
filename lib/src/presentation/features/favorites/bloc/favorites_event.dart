part of 'favorites_bloc.dart';

/// Base class for all events related to the favorites feature.
///
/// These events are dispatched from the UI to the [FavoritesBloc] to trigger
/// state changes.
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Event dispatched when the favorites screen is first opened.
///
/// This triggers the [FavoritesBloc] to start listening to the stream of
/// favorite dogs from the repository.
class FavoritesStarted extends FavoritesEvent {}

/// Event dispatched when the user removes a dog from the favorites list.
class FavoriteDogRemoved extends FavoritesEvent {
  /// The dog to be removed.
  final DogModel dog;

  /// Creates a [FavoriteDogRemoved] event.
  const FavoriteDogRemoved({required this.dog});

  @override
  List<Object> get props => <Object>[dog];
}

/// Event dispatched when the user re-adds a dog to the favorites list.
///
/// This event is used to add a dog back to favorites after it has been
/// temporarily removed within the same session on the favorites screen.
class FavoriteDogAdded extends FavoritesEvent {
  /// The dog to be added back.
  final DogModel dog;

  /// Creates a [FavoriteDogAdded] event.
  const FavoriteDogAdded({required this.dog});

  @override
  List<Object> get props => <Object>[dog];
}

class _UpdateDogs extends FavoritesEvent {
  final List<DogModel> dogs;

  const _UpdateDogs({required this.dogs});

  @override
  List<Object> get props => <Object>[dogs];
}
