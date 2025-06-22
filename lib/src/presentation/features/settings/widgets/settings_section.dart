import 'package:flutter/material.dart';

/// A reusable section widget for grouping settings options.
class SettingsSection extends StatelessWidget {
  /// Creates a [SettingsSection].
  const SettingsSection({required this.title, required this.child, super.key});

  /// The title of the section.
  final String title;

  /// The content of the section.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Section title
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            title,
            style: TextStyle(
              color: Theme.of(context).textTheme.titleMedium?.color,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
          ),
        ),
        // Section content
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black26
                    : Colors.black12,
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}
