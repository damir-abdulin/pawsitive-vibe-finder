import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../navigation/app_router.dart';

@RoutePage()
class QuizScoreScreen extends StatelessWidget {
  const QuizScoreScreen({
    required this.score,
    required this.totalQuestions,
    super.key,
  });

  final int score;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You scored',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '$score / $totalQuestions',
              style: Theme.of(
                context,
              ).textTheme.displayLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                context.router.replaceAll(<PageRouteInfo<Object?>>[
                  const QuizRoute(),
                ]);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
              ),
              child: const Text('Play Again'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                context.router.replaceAll(<PageRouteInfo<Object?>>[
                  HomeRoute(),
                ]);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
