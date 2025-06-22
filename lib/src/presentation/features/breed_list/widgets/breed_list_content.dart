import 'package:flutter/material.dart';

import '../../../../domain/models/breed_type.dart';
import '../bloc/breed_list_state.dart';
import 'widgets.dart';

/// Widget that displays the breed list content based on the current state.
class BreedListContent extends StatelessWidget {
  /// Creates a [BreedListContent].
  const BreedListContent({
    required this.state,
    required this.onRetry,
    required this.onBreedTap,
    super.key,
  });

  /// The current breed list state.
  final BreedListState state;

  /// Callback for retrying when an error occurs.
  final VoidCallback onRetry;

  /// Callback when a breed is tapped.
  final void Function(BreedType breed) onBreedTap;

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case BreedListStatus.loading:
        return const BreedListLoading();
      case BreedListStatus.failure:
        return BreedListErrorState(
          errorMessage: state.errorMessage,
          onRetry: onRetry,
        );
      case BreedListStatus.success:
        if (state.filteredBreeds.isEmpty) {
          return const BreedListEmptyState();
        }
        return BreedListView(
          breeds: state.filteredBreeds,
          onBreedTap: onBreedTap,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

/// Widget that displays the list of breeds.
class BreedListView extends StatelessWidget {
  /// Creates a [BreedListView].
  const BreedListView({
    required this.breeds,
    required this.onBreedTap,
    super.key,
  });

  /// The list of breeds to display.
  final List<BreedType> breeds;

  /// Callback when a breed is tapped.
  final void Function(BreedType breed) onBreedTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: breeds.length,
      itemBuilder: (BuildContext context, int index) {
        final BreedType breed = breeds[index];
        return BreedListItem(breed: breed, onTap: () => onBreedTap(breed));
      },
    );
  }
}
