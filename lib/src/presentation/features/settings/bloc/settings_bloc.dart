import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../navigation/app_router.dart';
import 'settings_event.dart';
import 'settings_state.dart';

/// BLoC for managing settings screen state and navigation.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  /// Creates a [SettingsBloc].
  SettingsBloc({required AppRouter router})
    : _router = router,
      super(const SettingsInitial()) {
    on<NavigateBackEvent>(_onNavigateBack);
  }

  final AppRouter _router;

  Future<void> _onNavigateBack(
    NavigateBackEvent event,
    Emitter<SettingsState> emit,
  ) async {
    _router.maybePop();
  }
}
