import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/services/connectivity_service.dart';

/// Implementation of [ConnectivityService] using the connectivity_plus package.
///
/// This service monitors network connectivity status to support the online/offline
/// functionality required by User Story 2.
class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;

  /// Creates an instance of [ConnectivityServiceImpl].
  const ConnectivityServiceImpl({required Connectivity connectivity})
    : _connectivity = connectivity;

  @override
  Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResults = await _connectivity
        .checkConnectivity();

    return _isConnectedFromResults(connectivityResults);
  }

  @override
  Stream<bool> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged.map(
      (List<ConnectivityResult> results) => _isConnectedFromResults(results),
    );
  }

  /// Determines if the device is connected based on connectivity results.
  bool _isConnectedFromResults(List<ConnectivityResult> results) {
    return results.any(
      (ConnectivityResult result) => result != ConnectivityResult.none,
    );
  }
}
