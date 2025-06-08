part of 'dog_details_bloc.dart';

abstract class DogDetailsEvent extends Equatable {
  const DogDetailsEvent();

  @override
  List<Object> get props => <Object>[];
}

class DogDetailsStarted extends DogDetailsEvent {}

class DogDetailsFavoriteToggled extends DogDetailsEvent {}
