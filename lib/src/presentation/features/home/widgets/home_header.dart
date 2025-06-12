import 'package:flutter/material.dart';
import '../../../theme/colors.dart';

/// Header widget for the home screen with the app title.
class HomeHeader extends StatelessWidget {
  /// Creates a [HomeHeader].
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryBackground.withOpacity(0.8),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 1),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'Doggo',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
