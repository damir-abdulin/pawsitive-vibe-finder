import 'dart:ui';
import 'package:flutter/material.dart';

/// Confirmation bottom sheet for quiz exit.
class QuizExitConfirmationSheet extends StatelessWidget {
  /// Creates a [QuizExitConfirmationSheet].
  const QuizExitConfirmationSheet({
    required this.onConfirmExit,
    required this.onContinueQuiz,
    super.key,
  });

  /// Callback when the user confirms to exit the quiz.
  final VoidCallback onConfirmExit;

  /// Callback when the user chooses to continue the quiz.
  final VoidCallback onContinueQuiz;

  /// Shows the quiz exit confirmation bottom sheet.
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirmExit,
    required VoidCallback onContinueQuiz,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (BuildContext context) => QuizExitConfirmationSheet(
        onConfirmExit: onConfirmExit,
        onContinueQuiz: onContinueQuiz,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.35,
          maxChildSize: 0.6,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFBF9F9), // Background color matching design
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
                  // Content - Make it scrollable to prevent overflow
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          // Warning icon
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFE8B4B7,
                              ).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.warning_rounded,
                              size: 40,
                              color: Color(0xFFE8B4B7),
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Title
                          const Text(
                            'Exit Quiz?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF191011), // Primary text color
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Description
                          const Text(
                            'Are you sure you want to exit? Your progress will be lost and you\'ll need to start over.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF4F4A4B), // Secondary text color
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          // Buttons
                          Column(
                            children: <Widget>[
                              // Continue Quiz button (primary)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: onContinueQuiz,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(
                                      0xFFE8B4B7,
                                    ), // Primary color
                                    foregroundColor: const Color(
                                      0xFF191011,
                                    ), // Primary text color
                                    elevation: 4,
                                    shadowColor: Colors.black.withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    minimumSize: const Size(
                                      double.infinity,
                                      56,
                                    ),
                                  ),
                                  child: const Text(
                                    'Continue Quiz',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Exit button (secondary)
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: onConfirmExit,
                                  style: TextButton.styleFrom(
                                    foregroundColor: const Color(
                                      0xFF8B5B5D,
                                    ), // Secondary text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 16,
                                    ),
                                    minimumSize: const Size(
                                      double.infinity,
                                      56,
                                    ),
                                  ),
                                  child: const Text(
                                    'Exit Quiz',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
