import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../localization/locale_extension.dart';
import '../../widgets/app_drawer.dart';
import 'bloc/home_bloc.dart';
import 'widgets/home_interaction_view.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is FirstLaunchState) {
          _showWelcomeDialog(context);
        }
        if (state is ShowOfflineDialog) {
          _showOfflineDialog(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text(context.locale.appTitle),
        ),
        drawer: const AppDrawer(),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (BuildContext context, HomeState state) {
            return switch (state) {
              HomeLoading() => const Center(child: CircularProgressIndicator()),
              SubsequentLaunchState() => HomeInteractionView(dogs: state.dogs),
              HomeError() => _ErrorView(message: state.message),
              FirstLaunchState() => const _InitialView(),
              HomeInitial() => const _InitialView(),
              ShowOfflineDialog() => const _InitialView(),
            };
          },
        ),
      ),
    );
  }

  Future<void> _showWelcomeDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(context.locale.homeWelcome),
          content: Text(context.locale.appTitle),
          actions: <Widget>[
            TextButton(
              child: Text(context.locale.homeGetStartedButton),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<HomeBloc>().add(CompleteFirstLaunchEvent());
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showOfflineDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(context.locale.offlineDialogTitle),
          content: Text(context.locale.offlineDialogMessage),
          actions: <Widget>[
            TextButton(
              child: Text(context.locale.okButton),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _InitialView extends StatelessWidget {
  const _InitialView();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Text(
          context.locale.homeWelcome,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Icon(Icons.error, size: 50, color: Theme.of(context).colorScheme.error),
        const SizedBox(height: 16),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        const SizedBox(height: 32),
      ],
    );
  }
}
