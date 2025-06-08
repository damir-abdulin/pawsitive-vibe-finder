import 'package:flutter/material.dart';

import '../../../widgets/image_card/image_card_controller.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.imageCardController, super.key});

  final ImageCardController imageCardController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _ActionButton(
            icon: Icons.close,
            color: Colors.red,
            onPressed: imageCardController.swipeLeft,
          ),
          _ActionButton(
            icon: Icons.favorite,
            color: Colors.green,
            onPressed: imageCardController.swipeRight,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(16),
        side: BorderSide(color: color, width: 2),
      ),
      child: Icon(icon, color: color, size: 30),
    );
  }
}
