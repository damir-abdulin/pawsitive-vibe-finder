import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/services/connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;

  ConnectivityServiceImpl({required Connectivity connectivity})
    : _connectivity = connectivity;

  @override
  Future<bool> isConnected() async {
    final List<ConnectivityResult> result = await _connectivity
        .checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
