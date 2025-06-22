import 'package:flutter/material.dart';


/// Header widget for the settings screen with back button and title.
class SettingsHeader extends StatelessWidget {
  /// Creates a [SettingsHeader].
  const SettingsHeader({required this.onBack, super.key});

  /// Callback when the back button is tapped.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.8),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, offset: Offset(0, 1), blurRadius: 1),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 16, 12),
          child: Row(
            children: <Widget>[
              // Back button
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onBack,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Title
              Expanded(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge?.color,
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
