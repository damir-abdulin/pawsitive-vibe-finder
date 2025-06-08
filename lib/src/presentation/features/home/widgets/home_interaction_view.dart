import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';
import '../../../utils/breed_type_localization.dart';
import '../../../widgets/image_card/image_card.dart';
import '../../../widgets/image_card/image_card_controller.dart';
import '../bloc/home_bloc.dart';
import 'action_buttons.dart';

/// A widget that displays a stack of dog images that can be swiped.
class HomeInteractionView extends StatefulWidget {
  /// Creates a [HomeInteractionView].
  const HomeInteractionView({required this.dogs, super.key});

  /// The list of dogs to display.
  final List<RandomDogModel> dogs;

  @override
  State<HomeInteractionView> createState() => _HomeInteractionViewState();
}

class _HomeInteractionViewState extends State<HomeInteractionView> {
  final ImageCardController _imageCardController = ImageCardController();

  @override
  Widget build(BuildContext context) {
    if (widget.dogs.isEmpty) {
      context.read<HomeBloc>().add(LoadHomeEvent());

      return const Center(child: CircularProgressIndicator.adaptive());
    }

    return Column(
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: widget.dogs.reversed.map((RandomDogModel dog) {
              final bool isTopCard = dog == widget.dogs.first;

              return IgnorePointer(
                ignoring: !isTopCard,
                child: ImageCard(
                  key: ValueKey<String>(dog.imageUrl),
                  controller: isTopCard ? _imageCardController : null,
                  imageUrl: dog.imageUrl,
                  title: dog.breed.toLocal(context),
                  onSwipeRight: () {
                    context.read<HomeBloc>().add(
                      SwipeRightEvent(dog: widget.dogs.first),
                    );
                  },
                  onSwipeLeft: () {
                    context.read<HomeBloc>().add(
                      SwipeLeftEvent(dog: widget.dogs.first),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 24),
        ActionButtons(imageCardController: _imageCardController),
        const SizedBox(height: 32),
      ],
    );
  }
}
