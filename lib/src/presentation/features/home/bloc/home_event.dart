part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class LoadHomeEvent extends HomeEvent {}

class CompleteFirstLaunchEvent extends HomeEvent {}

class SwipeRightEvent extends HomeEvent {
  final RandomDogModel dog;

  const SwipeRightEvent({required this.dog});
}

class SwipeLeftEvent extends HomeEvent {
  final RandomDogModel dog;

  const SwipeLeftEvent({required this.dog});
}
