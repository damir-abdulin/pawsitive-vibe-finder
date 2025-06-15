/// An abstract interface for checking network connectivity status.
///
/// This service provides methods to determine whether the device is currently
/// connected to the internet, which is essential for the offline functionality
/// described in User Story 2.
abstract class ConnectivityService {
  /// Checks if the device is currently connected to the internet.
  ///
  /// Returns `true` if the device has an active internet connection,
  /// `false` otherwise.
  Future<bool> isConnected();

  /// Gets a stream of connectivity status changes.
  ///
  /// This stream emits `true` when the device connects to the internet
  /// and `false` when it disconnects.
  Stream<bool> get onConnectivityChanged;
}
