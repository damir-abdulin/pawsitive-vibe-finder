import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pawsitive_vibe_finder/src/data/providers/providers.dart';
import 'package:pawsitive_vibe_finder/src/data/repository_impl/repository_impl.dart';
import 'package:pawsitive_vibe_finder/src/domain/domain.dart';
import 'package:pawsitive_vibe_finder/src/presentation/features/home/bloc/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt appLocator = GetIt.instance;

/// Initializes and registers all dependencies for the application.
Future<void> configureDependencies() async {
  // External
  appLocator.registerSingleton<Dio>(Dio());
  final sharedPreferences = await SharedPreferences.getInstance();
  appLocator.registerSingleton<SharedPreferences>(sharedPreferences);

  // Providers
  appLocator.registerSingleton<DogApiProvider>(
    DogApiProviderImpl(dio: appLocator()),
  );
  appLocator.registerSingleton<LocalPreferencesProvider>(
    LocalPreferencesProviderImpl(sharedPreferences: appLocator()),
  );

  // Repositories
  appLocator.registerSingleton<DogRepository>(
    DogRepositoryImpl(dogApiProvider: appLocator()),
  );
  appLocator.registerSingleton<PreferencesRepository>(
    PreferencesRepositoryImpl(localPreferencesProvider: appLocator()),
  );
  appLocator.registerSingleton<FavoritesRepository>(
    const FavoritesRepositoryImpl(),
  );

  // Use Cases
  appLocator.registerFactory(
    () => GetRandomDogUseCase(dogRepository: appLocator()),
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

  // BLoCs
  appLocator.registerFactory(
    () => HomeBloc(
      getRandomDogUseCase: appLocator(),
      checkFirstLaunchUseCase: appLocator(),
      setFirstLaunchCompletedUseCase: appLocator(),
      saveFavoriteDogUseCase: appLocator(),
    ),
  );
}
