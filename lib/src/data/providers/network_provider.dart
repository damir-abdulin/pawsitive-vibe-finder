import 'package:dio/dio.dart';

/// A network provider for making HTTP requests.
class NetworkProvider {
  /// The Dio instance for network requests.
  final Dio _dio;

  /// Creates a [NetworkProvider].
  ///
  /// The [dio] parameter is required and must not be null.
  const NetworkProvider({required Dio dio}) : _dio = dio;

  /// Performs a GET request.
  ///
  /// The [path] is the endpoint.
  /// The [queryParameters] are the query parameters.
  /// Returns a [Future<Response>] with the response.
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
