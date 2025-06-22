import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../../domain/use_case/get_breeds_use_case.dart';
import 'bloc/breed_list_bloc.dart';
import 'bloc/breed_list_event.dart';
import 'breed_list_body.dart';

/// A screen that displays a comprehensive list of dog breeds.
///
/// This screen implements User Story 1 functionality, providing users with
/// an organized, searchable list of all available dog breeds. Each breed
/// can be tapped to navigate to breed-specific content or image galleries.
///
/// Features:
/// - Complete list of all supported dog breeds
/// - Real-time search functionality with filtering
/// - Alphabetical organization with visual categorization
/// - Navigation to breed-specific home screen
/// - Navigation to breed image galleries
/// - Loading states and error handling
/// - Responsive design for different screen sizes
///
/// The screen uses [BlocProvider] to manage state through [BreedListBloc]
/// and automatically fetches the breed list when initialized.
///
/// Navigation example:
/// ```dart
/// // Navigate to breed list screen
/// context.router.navigate(const BreedListRoute());
/// ```
@RoutePage()
class BreedListScreen extends StatelessWidget {
  /// Creates a [BreedListScreen] widget.
  ///
  /// This screen automatically initializes the breed list loading process
  /// when created, providing an immediate user experience.
  const BreedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BreedListBloc>(
      create: (BuildContext context) =>
          BreedListBloc(getBreedsUseCase: appLocator<GetBreedsUseCase>())
            ..add(BreedListFetchRequested()),
      child: const BreedListBody(),
    );
  }
}
