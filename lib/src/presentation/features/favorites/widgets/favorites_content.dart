import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';
import '../bloc/favorites_bloc.dart';
import 'widgets.dart';

/// Widget that displays the favorites content based on the current state.
class FavoritesContent extends StatelessWidget {
  /// Creates a [FavoritesContent].
  const FavoritesContent({
    required this.state,
    required this.unfavoritedInSession,
    required this.onFavoriteToggle,
    required this.onImageTap,
    required this.onRetry,
    super.key,
  });

  /// The current favorites state.
  final FavoritesState state;

  /// Set of dogs that have been unfavorited in this session.
  final Set<String> unfavoritedInSession;

  /// Callback when favorite status is toggled.
  final void Function(DogModel dog, bool isFavorite) onFavoriteToggle;

  /// Callback when an image is tapped.
  final void Function(DogModel dog) onImageTap;

  /// Callback for retrying when an error occurs.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (state is FavoritesLoadInProgress) {
      return const FavoritesLoading();
    }

    if (state is FavoritesEmpty) {
      return const FavoritesEmptyState();
    }

    if (state is FavoritesLoadSuccess) {
      final FavoritesLoadSuccess successState = state as FavoritesLoadSuccess;
      return FavoritesGrid(
        dogs: successState.favoriteDogs,
        unfavoritedInSession: unfavoritedInSession,
        onFavoriteToggle: onFavoriteToggle,
        onImageTap: onImageTap,
      );
    }

    if (state is FavoritesLoadFailure) {
      final FavoritesLoadFailure failureState = state as FavoritesLoadFailure;
      return FavoritesErrorState(
        message: failureState.message,
        onRetry: onRetry,
      );
    }

    return const Center(child: Text('An unknown error occurred.'));
  }
}
