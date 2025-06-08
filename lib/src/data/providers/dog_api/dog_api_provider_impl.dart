import 'package:dio/dio.dart';

import '../../entities/entities.dart';
import '../exceptions/provider_exceptions.dart';
import 'dog_api_provider.dart';

/// The concrete implementation of [DogApiProvider] using the Dio package.
class DogApiProviderImpl implements DogApiProvider {
  final Dio _dio;
  static const String _baseUrl = 'https://dog.ceo/api';

  /// Creates an instance of [DogApiProviderImpl].
  DogApiProviderImpl({required Dio dio}) : _dio = dio;

  @override
  Future<DogResponseEntity> getRandomDog() async {
    try {
      final Response<dynamic> response = await _dio.get(
        '$_baseUrl/breeds/image/random',
      );
      if (response.statusCode == 200 && response.data != null) {
        return DogResponseEntity.fromJson(response.data);
      } else {
        throw NetworkException(
          'Failed to load random dog: Invalid response ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors, e.g., no internet connection
      throw NetworkException('Failed to load random dog: ${e.message}');
    } catch (e) {
      // Handle other unexpected errors
      throw ProviderException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<DogResponseEntity> getRandomDogByBreedPath({
    required String breedPath,
  }) async {
    try {
      final Response<dynamic> response = await _dio.get(
        '$_baseUrl/breed/$breedPath/images/random',
      );
      if (response.statusCode == 200 && response.data != null) {
        return DogResponseEntity.fromJson(response.data);
      } else {
        throw NetworkException(
          'Failed to load random dog for breed $breedPath: Invalid response ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors, e.g., no internet connection
      throw NetworkException(
        'Failed to load random dog for breed $breedPath: ${e.message}',
      );
    } catch (e) {
      // Handle other unexpected errors
      throw ProviderException('An unexpected error occurred: $e');
    }
  }
}
