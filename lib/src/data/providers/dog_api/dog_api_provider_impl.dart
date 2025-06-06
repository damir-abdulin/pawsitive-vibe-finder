import 'package:dio/dio.dart';
import 'package:pawsitive_vibe_finder/src/data/entities/entities.dart';
import 'package:pawsitive_vibe_finder/src/data/providers/dog_api/dog_api_provider.dart';
import 'package:pawsitive_vibe_finder/src/data/providers/exceptions/provider_exceptions.dart';

/// The concrete implementation of [DogApiProvider] using the Dio package.
class DogApiProviderImpl implements DogApiProvider {
  final Dio _dio;
  static const String _baseUrl = 'https://dog.ceo/api';

  /// Creates an instance of [DogApiProviderImpl].
  DogApiProviderImpl({required Dio dio}) : _dio = dio;

  @override
  Future<RandomDogEntity> getRandomDog() async {
    try {
      final response = await _dio.get('$_baseUrl/breeds/image/random');
      if (response.statusCode == 200 && response.data != null) {
        return RandomDogEntity.fromJson(response.data);
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
      throw ProviderException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
