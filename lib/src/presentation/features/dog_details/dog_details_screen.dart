import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../../domain/domain.dart';
import 'bloc/dog_details_bloc.dart';

@RoutePage()
/// A screen that displays a single dog's image in full-screen mode, allowing
/// the user to add or remove it from favorites.
class DogDetailsScreen extends StatelessWidget {
  /// The dog model to display.
  final DogModel dog;

  /// Creates a [DogDetailsScreen] instance.
  const DogDetailsScreen({required this.dog, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DogDetailsBloc>(
      create: (BuildContext context) => DogDetailsBloc(
        isFavoriteDogUseCase: appLocator(),
        saveFavoriteDogUseCase: appLocator(),
        removeFavoriteDogUseCase: appLocator(),
        dog: dog,
      )..add(DogDetailsStarted()),
      child: Builder(
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, _) {
              if (didPop) return;
              final DogDetailsState state = context
                  .read<DogDetailsBloc>()
                  .state;
              bool wasToggled = false;
              if (state is DogDetailsLoadSuccess) {
                wasToggled = state.wasToggled;
              }
              context.router.pop(wasToggled);
            },
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                actions: <Widget>[
                  BlocBuilder<DogDetailsBloc, DogDetailsState>(
                    builder: (BuildContext context, DogDetailsState state) {
                      if (state is DogDetailsLoadSuccess) {
                        return IconButton(
                          icon: Icon(
                            state.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          onPressed: () => context.read<DogDetailsBloc>().add(
                            DogDetailsFavoriteToggled(),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
              body: Builder(
                builder: (BuildContext context) {
                  return Center(
                    child: InteractiveViewer(
                      child: Hero(
                        tag: dog.imageUrl,
                        child: CachedNetworkImage(
                          imageUrl: dog.imageUrl,
                          fit: BoxFit.contain,
                          placeholder: (BuildContext context, String url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget:
                              (
                                BuildContext context,
                                String url,
                                Object error,
                              ) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
