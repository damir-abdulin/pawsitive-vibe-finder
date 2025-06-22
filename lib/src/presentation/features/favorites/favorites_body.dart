import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/domain.dart';
import '../../navigation/app_router.dart';
import '../../widgets/app_bottom_navigation.dart';
import 'bloc/favorites_bloc.dart';
import 'widgets/widgets.dart';

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

  void _onFavoriteToggle(DogModel dog, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        _unfavoritedInSession.add(dog.imageUrl);
        context.read<FavoritesBloc>().add(FavoriteDogRemoved(dog: dog));
      } else {
        _unfavoritedInSession.remove(dog.imageUrl);
        context.read<FavoritesBloc>().add(FavoriteDogAdded(dog: dog));
      }
    });
  }

  void _onImageTap(DogModel dog) async {
    final bool? wasToggled = await context.router.push<bool>(
      DogDetailsRoute(dog: dog),
    );
    if (wasToggled ?? false) {
      if (context.mounted) {
        context.read<FavoritesBloc>().add(FavoritesRefreshed());
        _unfavoritedInSession.clear();
      }
    }
  }

  void _onRetry() {
    context.read<FavoritesBloc>().add(FavoritesRefreshed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          // Sticky header
          const FavoritesHeader(),
          // Main content
          Expanded(
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (BuildContext context, FavoritesState state) {
                return _buildContent(state);
              },
            ),
          ),
          // Bottom navigation
          const AppBottomNavigation(currentRoute: 'FavoritesRoute'),
        ],
      ),
    );
  }

  Widget _buildContent(FavoritesState state) {
    if (state is FavoritesLoadInProgress) {
      return const FavoritesLoading();
    }

    if (state is FavoritesEmpty) {
      return const FavoritesEmptyState();
    }

    if (state is FavoritesLoadSuccess) {
      return FavoritesGrid(
        dogs: state.favoriteDogs,
        unfavoritedInSession: _unfavoritedInSession,
        onFavoriteToggle: _onFavoriteToggle,
        onImageTap: _onImageTap,
      );
    }

    if (state is FavoritesLoadFailure) {
      return FavoritesErrorState(message: state.message, onRetry: _onRetry);
    }

    return const Center(child: Text('An unknown error occurred.'));
  }
}
