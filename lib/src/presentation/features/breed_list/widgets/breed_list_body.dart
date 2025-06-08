import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/breed_model.dart';
import '../../../widgets/app_drawer.dart';

import '../bloc/breed_list_bloc.dart';
import '../bloc/breed_list_event.dart';
import '../bloc/breed_list_state.dart';

/// The body of the breed list screen.
class BreedListBody extends StatefulWidget {
  /// Creates a [BreedListBody].
  const BreedListBody({super.key});

  @override
  State<BreedListBody> createState() => _BreedListBodyState();
}

class _BreedListBodyState extends State<BreedListBody> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

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

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: _isSearching ? _buildSearchField() : const Text('Dog Breeds'),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: _toggleSearch,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: BlocBuilder<BreedListBloc, BreedListState>(
        builder: (BuildContext context, BreedListState state) {
          switch (state.status) {
            case BreedListStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case BreedListStatus.failure:
              return Center(
                child: Text(state.errorMessage ?? 'Failed to load breeds'),
              );
            case BreedListStatus.success:
              if (state.filteredBreeds.isEmpty) {
                return const Center(child: Text('No breeds found'));
              }
              return ListView.builder(
                itemCount: state.filteredBreeds.length,
                itemBuilder: (BuildContext context, int index) {
                  final BreedModel breed = state.filteredBreeds[index];
                  return ListTile(
                    title: Text(breed.displayName),
                    onTap: () {
                      // TODO: Navigate to breed details screen
                    },
                  );
                },
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search breeds...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white54),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 18),
    );
  }
}
