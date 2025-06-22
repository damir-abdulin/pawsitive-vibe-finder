import 'package:flutter/material.dart';

import '../../../localization/locale_extension.dart';
import '../../../theme/app_constants.dart';

/// Widget that displays the first launch welcome view with animation.
class HomeFirstLaunchView extends StatelessWidget {
  /// Creates a [HomeFirstLaunchView].
  const HomeFirstLaunchView({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: AppConstants.welcomeAnimationDuration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (BuildContext context, double value, Widget? child) {
        return Transform.scale(
          scale: value,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.extraLargePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.pets,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: AppConstants.largePadding),
                  Text(
                    context.locale.welcomeToApp,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: AppConstants.mediumLetterSpacing,
                    ),
                  ),
                  const SizedBox(height: AppConstants.smallPadding),
                  Text(
                    context.locale.pawsitivityMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: AppConstants.defaultLineHeight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
