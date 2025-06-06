part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class FirstLaunchState extends HomeState {}

class SubsequentLaunchState extends HomeState {
  final String imageUrl;
  final String breed;

  const SubsequentLaunchState({required this.imageUrl, required this.breed});

  @override
  List<Object> get props => [imageUrl, breed];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
