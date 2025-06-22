import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../localization/locale_extension.dart';
import '../../../navigation/app_router.dart';

/// Header widget for the home screen with the app title.
class HomeHeader extends StatelessWidget {
  /// Creates a [HomeHeader].
  const HomeHeader({super.key});

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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  context.locale.appTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.titleLarge?.color,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.25,
                  ),
                ),
              ),
              // Settings dropdown menu
              IconButton(
                onPressed: () {
                  context.router.push(const SettingsRoute());
                },
                icon: Icon(
                  Icons.settings,
                  color: Theme.of(context).iconTheme.color,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
