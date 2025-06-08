part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent {}

class CompleteFirstLaunchEvent extends HomeEvent {}

class SwipeRightEvent extends HomeEvent {
  final DogModel dog;

  const SwipeRightEvent({required this.dog});
}

class SwipeLeftEvent extends HomeEvent {
  final DogModel dog;

  const SwipeLeftEvent({required this.dog});
}
