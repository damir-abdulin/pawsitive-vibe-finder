part of 'dog_details_bloc.dart';

abstract class DogDetailsState extends Equatable {
  const DogDetailsState();

  @override
  List<Object> get props => <Object>[];
}

class DogDetailsInitial extends DogDetailsState {}

class DogDetailsLoadInProgress extends DogDetailsState {}

class DogDetailsLoadSuccess extends DogDetailsState {
  final bool isFavorite;
  final bool wasToggled;

  const DogDetailsLoadSuccess({
    required this.isFavorite,
    this.wasToggled = false,
  });

  @override
  List<Object> get props => <Object>[isFavorite, wasToggled];

  DogDetailsLoadSuccess copyWith({bool? isFavorite, bool? wasToggled}) {
    return DogDetailsLoadSuccess(
      isFavorite: isFavorite ?? this.isFavorite,
      wasToggled: wasToggled ?? this.wasToggled,
    );
  }
}
