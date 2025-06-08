import 'package:equatable/equatable.dart';

/// The base class for all breed list events.
abstract class BreedListEvent extends Equatable {
  /// Creates a [BreedListEvent].
  const BreedListEvent();

  @override
  List<Object> get props => <Object>[];
}

/// An event to fetch the list of breeds.
class BreedListFetchRequested extends BreedListEvent {}

/// An event to handle changes in the search query.
class BreedListSearchChanged extends BreedListEvent {
  /// The search query.
  final String query;

  /// Creates a [BreedListSearchChanged] event.
  const BreedListSearchChanged(this.query);

  @override
  List<Object> get props => <Object>[query];
}
