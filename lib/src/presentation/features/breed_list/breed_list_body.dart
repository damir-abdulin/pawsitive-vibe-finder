import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/models/breed_type.dart';
import '../../navigation/app_router.dart';
import '../../widgets/app_bottom_navigation.dart';

import 'bloc/breed_list_bloc.dart';
import 'bloc/breed_list_event.dart';
import 'bloc/breed_list_state.dart';
import 'widgets/widgets.dart';

/// The body of the breed list screen.
class BreedListBody extends StatefulWidget {
  /// Creates a [BreedListBody].
  const BreedListBody({super.key});

  @override
  State<BreedListBody> createState() => _BreedListBodyState();
}

class _BreedListBodyState extends State<BreedListBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<BreedListBloc>().add(
      BreedListSearchChanged(_searchController.text),
    );
  }

  void _onRetry() {
    context.read<BreedListBloc>().add(BreedListFetchRequested());
  }

  void _onBreedTap(BreedType breed) {
    context.router.push(BreedImagesSlideshowRoute(breed: breed));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Sticky header with title and search
            BreedListHeader(
              searchController: _searchController,
              onSearchChanged: _onSearchChanged,
            ),
            // Main content
            Expanded(
              child: BlocBuilder<BreedListBloc, BreedListState>(
                builder: (BuildContext context, BreedListState state) {
                  return BreedListContent(
                    state: state,
                    onRetry: _onRetry,
                    onBreedTap: _onBreedTap,
                  );
                },
              ),
            ),
            // Bottom navigation
            const AppBottomNavigation(currentRoute: 'BreedListRoute'),
          ],
        ),
      ),
    );
  }
}
