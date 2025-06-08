import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization/locale_extension.dart';
import 'bloc/favorites_bloc.dart';
import 'widgets/favorite_dog_card.dart';

/// The body of the favorites screen.
///
/// This widget listens to the [FavoritesBloc] and displays the UI based on
/// the current state. It shows a loading indicator, an empty state message,
/// or a grid of favorite dogs.
class FavoritesBody extends StatefulWidget {
  const FavoritesBody({super.key});

  @override
  State<FavoritesBody> createState() => _FavoritesBodyState();
}

class _FavoritesBodyState extends State<FavoritesBody> {
  // A local set to keep track of which dogs have been un-favorited
  // during this session, so the heart icon can be updated instantly.
  final Set<String> _unfavoritedInSession = <String>{};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (BuildContext context, FavoritesState state) {
        if (state is FavoritesLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is FavoritesEmpty) {
          return Center(child: Text(context.locale.favoritesEmptyMessage));
        }
        if (state is FavoritesLoadSuccess) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: state.favoriteDogs.length,
            itemBuilder: (BuildContext context, int index) {
              final dog = state.favoriteDogs[index];
              final isFavorite = !_unfavoritedInSession.contains(dog.imageUrl);

              return FavoriteDogCard(
                dog: dog,
                isFavorite: isFavorite,
                onFavoritePressed: () {
                  setState(() {
                    if (isFavorite) {
                      _unfavoritedInSession.add(dog.imageUrl);
                      context.read<FavoritesBloc>().add(
                        FavoriteDogRemoved(dog: dog),
                      );
                    } else {
                      _unfavoritedInSession.remove(dog.imageUrl);
                      context.read<FavoritesBloc>().add(
                        FavoriteDogAdded(dog: dog),
                      );
                    }
                  });
                },
              );
            },
          );
        }
        return const Center(child: Text('An unknown error occurred.'));
      },
    );
  }
}
