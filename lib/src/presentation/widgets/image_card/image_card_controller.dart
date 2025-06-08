import 'package:flutter/material.dart';

enum ImageCardEvent { swipeRight, swipeLeft }

class ImageCardController extends ValueNotifier<ImageCardEvent?> {
  ImageCardController() : super(null);

  void swipeRight() {
    value = ImageCardEvent.swipeRight;
  }

  void swipeLeft() {
    value = ImageCardEvent.swipeLeft;
  }

  @override
  ImageCardEvent? get value {
    final ImageCardEvent? event = super.value;
    super.value = null;

    return event;
  }
}
