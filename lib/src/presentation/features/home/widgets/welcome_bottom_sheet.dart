import 'dart:ui';
import 'package:flutter/material.dart';

/// Welcome bottom sheet dialog for first launch.
class WelcomeBottomSheet extends StatelessWidget {
  /// Creates a [WelcomeBottomSheet].
  const WelcomeBottomSheet({required this.onGetStarted, super.key});

  /// Callback when the "Get Started" button is pressed.
  final VoidCallback onGetStarted;

  /// Shows the welcome bottom sheet.
  static Future<void> show(BuildContext context, VoidCallback onGetStarted) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext context) =>
          WelcomeBottomSheet(onGetStarted: onGetStarted),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          maxChildSize: 0.8,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFBF9F9), // Background color from design
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: <Widget>[
                  // Modal handle
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Container(
                        height: 6,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3D4D5), // Modal handle color
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          // Icon
                          const Icon(
                            Icons.pets,
                            size: 96,
                            color: Color(0xFFE8B4B7), // Primary color
                          ),
                          const SizedBox(height: 32),
                          // Title
                          const Text(
                            'Welcome to Doggy Delights!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF191011), // Primary text color
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Description
                          const Text(
                            'Explore a world of adorable dog breeds and their delightful photos. Get ready to be charmed!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4F4A4B), // Secondary text color
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 48),
                          // Get Started button
                          SizedBox(
                            width: double.infinity,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 320),
                              child: ElevatedButton(
                                onPressed: onGetStarted,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                    0xFFE8B4B7,
                                  ), // Primary color
                                  foregroundColor: const Color(
                                    0xFF191011,
                                  ), // Primary text color
                                  elevation: 8,
                                  shadowColor: Colors.black.withValues(
                                    alpha: 0.3,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  minimumSize: const Size(double.infinity, 56),
                                ),
                                child: const Text(
                                  'Get Started!',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
