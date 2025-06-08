import 'package:dio/dio.dart';

import '../../providers/network_provider.dart';
import '../exceptions/breed_provider_exception.dart';

/// A provider for fetching breed data from the Dog CEO API.
class BreedProvider {
  /// The network provider for making HTTP requests.
  final NetworkProvider _networkProvider;

  /// The base URL for the Dog CEO API.
  final String _baseUrl;

  /// Creates a [BreedProvider].
  ///
  /// The [networkProvider] and [baseUrl] are required.
  const BreedProvider({
    required NetworkProvider networkProvider,
    required String baseUrl,
  }) : _networkProvider = networkProvider,
       _baseUrl = baseUrl;

  /// Fetches the list of all dog breeds.
  ///
  /// Returns a [Response] with the breed data.
  /// Throws a [BreedProviderException] if the request fails.
  Future<Response<dynamic>> getBreeds() async {
    try {
      return await _networkProvider.get('$_baseUrl/breeds/list/all');
    } on DioException catch (e) {
      throw BreedProviderException('Failed to fetch breeds: ${e.message}');
    }
  }
}
