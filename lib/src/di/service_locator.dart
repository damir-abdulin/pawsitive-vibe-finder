import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/providers/providers.dart';
import '../data/repository_impl/repository_impl.dart';
import '../data/services/connectivity_service_impl.dart';
import '../domain/repository/repository.dart';
import '../domain/services/connectivity_service.dart';
import '../domain/use_case/use_cases.dart';
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
  appLocator.registerLazySingleton<DogApiProvider>(
    () => DogApiProviderImpl(dio: appLocator()),
  );
  appLocator.registerSingleton<LocalPreferencesProvider>(
    LocalPreferencesProviderImpl(sharedPreferences: appLocator()),
  );

  // Repositories
  appLocator.registerLazySingleton<DogRepository>(
    () => DogRepositoryImpl(dogApiProvider: appLocator()),
  );
  appLocator.registerLazySingleton<PreferencesRepository>(
    () => PreferencesRepositoryImpl(localPreferencesProvider: appLocator()),
  );
  appLocator.registerLazySingleton<FavoritesRepository>(
    () => const FavoritesRepositoryImpl(),
  );

  // Use Cases
  appLocator.registerFactory(
    () => GetRandomDogUseCase(dogRepository: appLocator()),
  );
  appLocator.registerFactory(
    () => GetRandomDogsUseCase(dogRepository: appLocator()),
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
