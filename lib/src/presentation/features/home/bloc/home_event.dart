part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeEvent extends HomeEvent {}

class CompleteFirstLaunchEvent extends HomeEvent {}

class SwipeRightEvent extends HomeEvent {
  final RandomDogModel dog;
  const SwipeRightEvent({required this.dog});
  @override
  List<Object> get props => [dog];
}

class SwipeLeftEvent extends HomeEvent {}
