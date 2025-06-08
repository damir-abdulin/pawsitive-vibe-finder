part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => <Object>[];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class FirstLaunchState extends HomeState {}

class SubsequentLaunchState extends HomeState {
  final List<DogModel> dogs;

  const SubsequentLaunchState({required this.dogs});

  @override
  List<Object> get props => <Object>[dogs];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => <Object>[message];
}

class ShowOfflineDialog extends HomeState {}
