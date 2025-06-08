import 'package:equatable/equatable.dart';

/// A model representing a dog breed.
class BreedModel extends Equatable {
  /// The display name of the breed.
  final String displayName;

  /// The path for the API request.
  final String requestPath;

  /// Creates a [BreedModel].
  const BreedModel({required this.displayName, required this.requestPath});

  @override
  List<Object?> get props => <Object?>[displayName, requestPath];
}
