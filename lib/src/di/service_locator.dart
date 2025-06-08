import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/providers/providers.dart';
import '../data/repository_impl/breed_repository_impl.dart';
import '../data/repository_impl/repository_impl.dart';
import '../data/services/connectivity_service_impl.dart';
import '../domain/domain.dart';
import '../domain/services/connectivity_service.dart';
import '../presentation/navigation/app_router.dart';

final GetIt appLocator = GetIt.instance;

/// Initializes and registers all dependencies for the application.
Future<void> configureDependencies() async {
  // External
  appLocator.registerLazySingleton<Dio>(Dio.new);
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  appLocator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  appLocator.registerLazySingleton<Connectivity>(Connectivity.new);

  // Services
  appLocator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(connectivity: appLocator()),
  );

  // Providers
  appLocator.registerLazySingleton<NetworkProvider>(
    () => NetworkProvider(dio: appLocator()),
  );
  appLocator.registerSingleton<AppDatabase>(AppDatabase());
  appLocator.registerLazySingleton<DogApiProvider>(
    () => DogApiProviderImpl(dio: appLocator()),
  );
  appLocator.registerSingleton<LocalPreferencesProvider>(
    LocalPreferencesProviderImpl(sharedPreferences: appLocator()),
  );

  // DAO
  appLocator.registerLazySingleton<FavoriteDogDao>(
    () => FavoriteDogDao(appLocator()),
  );

  // Repositories
  appLocator.registerLazySingleton<BreedRepository>(BreedRepositoryImpl.new);
  appLocator.registerLazySingleton<DogRepository>(
    () => DogRepositoryImpl(dogApiProvider: appLocator()),
  );
  appLocator.registerLazySingleton<PreferencesRepository>(
    () => PreferencesRepositoryImpl(localPreferencesProvider: appLocator()),
  );
  appLocator.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(favoriteDogDao: appLocator()),
  );

  // Use Cases
  appLocator.registerFactory(
    () => GetBreedsUseCase(breedRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => GetRandomDogUseCase(dogRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => GetRandomDogsUseCase(dogRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => GetFavoriteDogsUseCase(favoritesRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => RemoveFavoriteDogUseCase(favoritesRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => IsFavoriteDogUseCase(favoritesRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => CheckFirstLaunchUseCase(preferencesRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => SetFirstLaunchCompletedUseCase(preferencesRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => SaveFavoriteDogUseCase(favoritesRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => SaveLastDogUseCase(preferencesRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => GetLastDogUseCase(preferencesRepository: appLocator()),
  );

  appLocator.registerLazySingleton(AppRouter.new);
}
