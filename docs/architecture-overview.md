# Pawsitive Vibe Finder - Architecture Overview

This document outlines the software architecture for the "Pawsitive Vibe Finder" mobile application. The architecture is designed to be scalable, maintainable, and testable, adhering to Clean Architecture principles and leveraging a modern Flutter tech stack.

## 1. Core Architectural Principles

The application follows a Clean Architecture approach, strictly dividing the software into layers with specific responsibilities. This promotes separation of concerns, making the system easier to understand, develop, and maintain.

* **Dependency Rule**: Source code dependencies only point inwards. Inner layers are independent of outer layers.
* **Layer Independence**:
    * The domain layer (core business logic) is independent of UI, databases, and frameworks.
    * The data layer is independent of the UI.
    * The presentation layer depends on the domain layer.
* **Testability**: Each layer can be tested independently.
* **Maintainability & Scalability**: Changes in one layer (e.g., UI framework, database) have minimal impact on others.

The project structure is primarily divided into four main layers:

* **domain** (Core Business Logic)
* **data** (Infrastructure & Implementation)
* **presentation** (User Interface)
* **di** (Dependency Injection)

## 2. Layer Responsibilities

### 2.1. domain Layer

This is the innermost layer containing enterprise-wide business rules and abstractions. It's pure Dart and has no Flutter dependencies.

* **use_case**: Contains application-specific business rules. Use cases orchestrate interactions between models and repository interfaces. All use cases extend `UseCase`, `FutureUseCase`, or `StreamUseCase`.
    * **Examples for Pawsitive Vibe Finder**:
        * `CheckFirstLaunchUseCase`: Determines if it's the user's first app launch.
        * `SetFirstLaunchCompletedUseCase`: Marks the first launch sequence as complete.
        * `GetRandomDogImageUseCase`: Fetches a random dog image and its breed.
        * `GetAllBreedsUseCase`: Retrieves the complete list of dog breeds.
        * `GetRandomImageForBreedUseCase`: Fetches a random image for a specified breed.
        * `AddImageToFavoritesUseCase`: Adds an image URL to the user's favorites.
        * `RemoveImageFromFavoritesUseCase`: Removes an image URL from favorites.
        * `GetFavoriteImagesUseCase`: Retrieves all favorited image URLs.
        * `GetFavoriteStatusUseCase`: Checks if a specific image is favorited.
        * `AddBreedToRecentlyViewedUseCase`: Adds a breed to the recently viewed list.
        * `GetRecentlyViewedBreedsUseCase`: Retrieves the list of recently viewed breeds.
        * `GetThemeSettingUseCase`: Retrieves the current theme preference.
        * `SetThemeSettingUseCase`: Saves the user's theme preference.
        * `GetLanguageSettingUseCase`: Retrieves the current language preference.
        * `SetLanguageSettingUseCase`: Saves the user's language preference.
* **repository**: Defines abstract interfaces (contracts) for data operations.
    * `DogRepository`: Interface for fetching dog images and breed lists from an external API.
    * `FavoritesRepository`: Interface for managing the local persistence of favorite image URLs.
    * `RecentlyViewedRepository`: Interface for managing the local persistence of recently viewed breed identifiers.
    * `SettingsRepository`: Interface for managing user preferences like first launch status, theme, and language.
* **models**: Pure Dart objects representing business entities. These are immutable.
    * `DogImageModel`: Represents a dog image, containing its URL and extracted breed name (e.g., `imageUrl: String`, `breedName: String`).
    * `BreedModel`: Represents a dog breed, containing its display name and API request path (e.g., `displayName: String`, `apiRequestPath: String`).
    * `FavoriteImageModel`: Represents a favorited image, primarily its URL (e.g., `imageUrl: String`).
    * `RecentlyViewedBreedModel`: Represents a recently viewed breed, containing its display name and API path for navigation (e.g., `displayName: String`, `apiRequestPath: String`).
* **exceptions**: Custom domain-specific exceptions.
    * `AppException`: Base class for domain exceptions.
    * `NetworkException`: For network-related errors during data fetching.
    * `NoDataFoundException`: When expected data is not found (e.g., no image for a breed).
    * `LocalStorageException`: For errors related to local data persistence.

### 2.2. data Layer

This layer implements the repository interfaces from the domain layer and handles all interactions with external data sources.

* **repository_impl**: Concrete implementations of the repository interfaces.
    * `DogRepositoryImpl`: Implements `DogRepository` using `DogApiProvider`.
    * `FavoritesRepositoryImpl`: Implements `FavoritesRepository` using `DriftDatabaseProvider` (for drift).
    * `RecentlyViewedRepositoryImpl`: Implements `RecentlyViewedRepository` using `SharedPreferencesProvider`.
    * `SettingsRepositoryImpl`: Implements `SettingsRepository` using `SharedPreferencesProvider`.
* **providers**: Classes for direct interaction with data sources.
    * **remote**:
        * `DogApiProvider`: Uses `dio` to interact with the `dog.ceo/dog-api`. Handles API request construction, response parsing, and API-specific error handling.
    * **local**:
        * `SharedPreferencesProvider`: Manages simple key-value storage using `shared_preferences` (for first launch flag, theme/language preferences, recently viewed breed IDs).
        * `DriftDatabaseProvider`: Manages structured local data using `drift` (SQLite). Includes database definition, DAOs (Data Access Objects) for caching the breed list and storing favorite image URLs.
* **entities**: Data structures representing raw data from providers (e.g., JSON responses). Often generated using `json_serializable`.
    * `DogImageEntity`: Represents the JSON response for a random dog image.
    * `BreedListResponseEntity`: Represents the JSON response for the list of all breeds.
    * `FavoriteImageEntity`: Represents a favorite image record in the drift database.
    * `BreedEntity`: Represents a breed record in the drift database (for caching).
* **mappers**: Classes for converting data between entities (data layer) and models (domain layer).
    * `DogImageMapper`: Converts `DogImageEntity` to `DogImageModel`.
    * `BreedMapper`: Converts `BreedListResponseEntity` and individual breed data to a list of `BreedModel` objects. Also handles mapping `BreedModel` to `BreedEntity` for caching.
    * `FavoriteImageMapper`: Converts `FavoriteImageEntity` to `FavoriteImageModel` and vice-versa.

### 2.3. presentation Layer

This layer is responsible for the UI and user interaction, built with Flutter. It uses BLoC for state management.

* **features**: UI code organized by application feature.
    * **home**:
        * `bloc`: `HomeBloc`, `HomeEvent`, `HomeState`. Manages state for the home screen including first launch welcome, random dog image display, and swipe interactions.
        * `widgets`: Reusable widgets specific to the home screen.
        * `home_screen.dart`: Entry point for the home feature, sets up `BlocProvider`.
        * `home_body.dart`: Contains the actual UI for the home screen.
    * **breed_list**:
        * `bloc`: `BreedListBloc`, `BreedListEvent`, `BreedListState`. Manages state for displaying and searching the dog breed list.
        * `widgets`: Widgets for list items, search bar.
        * `breed_list_screen.dart`: Entry point for the breed list feature.
        * `breed_list_body.dart`: UI for displaying the breed list.
    * **breed_image**:
        * `bloc`: `BreedImageBloc`, `BreedImageEvent`, `BreedImageState`. Manages state for displaying random images of a specific breed and swipe interactions.
        * `widgets`: Image display widgets.
        * `breed_image_screen.dart`: Entry point, receives selected breed.
        * `breed_image_body.dart`: UI for the breed image viewer.
    * **favorites**:
        * `bloc`: `FavoritesBloc`, `FavoritesEvent`, `FavoritesState`. Manages state for displaying and managing favorite images.
        * `widgets`: Grid item widgets for favorite images.
        * `favorites_screen.dart`: Entry point for the favorites feature.
        * `favorites_body.dart`: UI for the favorites grid.
    * **recently_viewed**: (Likely part of the `app_drawer` or a simple screen)
        * `bloc`: `RecentlyViewedBloc`, `RecentlyViewedEvent`, `RecentlyViewedState`. Manages state for displaying recently viewed breeds.
        * `widgets`: List item for recently viewed breeds.
        * (Optional) `recently_viewed_screen.dart` / `recently_viewed_body.dart`.
    * **settings**: (Integrated within the `app_drawer` or a settings screen)
        * `bloc`: `ThemeBloc`, `LanguageBloc` (and corresponding events/states) for managing theme and language changes.
    * **widgets**: Common, reusable UI components across multiple features (e.g., `AppDrawer`, custom buttons, dialogs).
* **theme**:
    * `app_theme.dart`: Defines `ThemeData` for light and dark modes.
    * `colors.dart`: Application color palette.
* **localization**:
    * `l10n/`: Contains `.arb` files for English (`en`), Spanish (`es`), German (`de`), and French (`fr`).
    * `app_localizations.dart`: Generated.
    * `locale_extension.dart`: Extension on `BuildContext` for easy access to `AppLocalizations`.
* **navigation** (or router):
    * `app_router.dart`: Configures and manages navigation using `auto_route`. Defines routes for all screens.
    * `app_router.gr.dart`: Generated file by `auto_route`.

### 2.4. di Layer (Dependency Injection)

This layer manages the creation and provision of dependencies using `get_it`.

* **service_locator.dart**: Initializes and registers all dependencies (use cases, repositories, providers, BLoCs as factories if they have params, services as singletons/lazySingletons).
    * **Use Cases**: Registered as factory as they might hold execution-specific state or are lightweight.
    * **Repositories & Providers**: Registered as lazySingleton if stateless and a single instance is sufficient.
    * **BLoCs**: Typically provided at the widget tree level using `BlocProvider`, but their dependencies are resolved via `get_it`.

## 3. Folder Structure

The project will follow a structure that reflects the layers:

pawsitive_vibe_finder/
├── lib/
│   ├── main.dart                      # Application entry point
│   ├── app.dart                       # Root widget (MaterialApp, BlocProviders, Router)
│   ├── src/
│   │   ├── di/
│   │   │   └── service_locator.dart
│   │   ├── domain/
│   │   │   ├── use_case/
│   │   │   │   ├── home/
│   │   │   │   │   ├── check_first_launch_use_case.dart
│   │   │   │   │   ├── set_first_launch_completed_use_case.dart
│   │   │   │   │   └── get_random_dog_image_use_case.dart
│   │   │   │   ├── breed_list/
│   │   │   │   │   └── get_all_breeds_use_case.dart
│   │   │   │   ├── breed_image/
│   │   │   │   │   ├── get_random_image_for_breed_use_case.dart
│   │   │   │   │   └── add_breed_to_recently_viewed_use_case.dart
│   │   │   │   ├── favorites/
│   │   │   │   │   ├── add_image_to_favorites_use_case.dart
│   │   │   │   │   ├── remove_image_from_favorites_use_case.dart
│   │   │   │   │   ├── get_favorite_images_use_case.dart
│   │   │   │   │   └── get_favorite_status_use_case.dart
│   │   │   │   ├── recently_viewed/
│   │   │   │   │   └── get_recently_viewed_breeds_use_case.dart
│   │   │   │   └── settings/
│   │   │   │       ├── get_theme_setting_use_case.dart
│   │   │   │       ├── set_theme_setting_use_case.dart
│   │   │   │       ├── get_language_setting_use_case.dart
│   │   │   │       └── set_language_setting_use_case.dart
│   │   │   ├── repository/
│   │   │   │   ├── dog_repository.dart
│   │   │   │   ├── favorites_repository.dart
│   │   │   │   ├── recently_viewed_repository.dart
│   │   │   │   └── settings_repository.dart
│   │   │   ├── models/
│   │   │   │   ├── dog_image_model.dart
│   │   │   │   ├── breed_model.dart
│   │   │   │   ├── favorite_image_model.dart
│   │   │   │   └── recently_viewed_breed_model.dart
│   │   │   └── exceptions/
│   │   │       ├── app_exception.dart
│   │   │       ├── network_exception.dart
│   │   │       ├── no_data_found_exception.dart
│   │   │       └── local_storage_exception.dart
│   │   ├── data/
│   │   │   ├── repository_impl/
│   │   │   │   ├── dog_repository_impl.dart
│   │   │   │   ├── favorites_repository_impl.dart
│   │   │   │   ├── recently_viewed_repository_impl.dart
│   │   │   │   └── settings_repository_impl.dart
│   │   │   ├── providers/
│   │   │   │   ├── remote/
│   │   │   │   │   └── dog_api_provider.dart
│   │   │   │   └── local/
│   │   │   │       ├── shared_preferences_provider.dart
│   │   │   │       ├── drift_database_provider.dart # Defines AppDatabase
│   │   │   │       └── dao/                       # Drift DAOs
│   │   │   │           ├── breed_dao.dart
│   │   │   │           └── favorite_image_dao.dart
│   │   │   ├── entities/
│   │   │   │   ├── remote/ # Entities from API responses
│   │   │   │   │   ├── dog_image_entity.dart
│   │   │   │   │   └── breed_list_response_entity.dart
│   │   │   │   └── local/  # Entities for Drift tables
│   │   │   │       ├── breed_entity.dart
│   │   │   │       └── favorite_image_entity.dart
│   │   │   └── mappers/
│   │   │       ├── dog_image_mapper.dart
│   │   │       ├── breed_mapper.dart
│   │   │       └── favorite_image_mapper.dart
│   │   ├── presentation/
│   │   │   ├── features/
│   │   │   │   ├── home/
│   │   │   │   │   ├── bloc/ (home_bloc.dart, home_event.dart, home_state.dart)
│   │   │   │   │   ├── widgets/
│   │   │   │   │   ├── home_screen.dart
│   │   │   │   │   └── home_body.dart
│   │   │   │   ├── breed_list/ (similar structure)
│   │   │   │   ├── breed_image/ (similar structure)
│   │   │   │   ├── favorites/ (similar structure)
│   │   │   │   └── recently_viewed/ (similar structure, might be simpler)
│   │   │   ├── widgets/ # Common widgets
│   │   │   │   └── app_drawer.dart
│   │   │   ├── theme/
│   │   │   │   ├── app_theme.dart
│   │   │   │   └── colors.dart
│   │   │   ├── localization/
│   │   │   │   ├── l10n/ (app_en.arb, app_es.arb, etc.)
│   │   │   │   ├── app_localizations.dart # Generated
│   │   │   │   └── locale_extension.dart
│   │   │   └── navigation/
│   │   │       ├── app_router.dart
│   │   │       └── app_router.gr.dart # Generated
│   │   ├── core/ # Utilities, constants, etc.
│   │   │   ├── constants/
│   │   │   │   └── app_constants.dart
│      │   │   ├── extensions/
│   │   │   │   └── string_extension.dart # e.g., for capitalizing breed names
│   │   │   ├── network/
│   │   │   │   └── connectivity_service.dart # To check online/offline status
│   │   │   └── utils/
│   │   │       └── breed_parser.dart # Utility to parse breed from image URL
├── test/
│   └── ... (mirroring src structure for unit and widget tests)
├── analysis_options.yaml
└── pubspec.yaml

## 4. Used API Description (Dog API)

The application primarily interacts with the Dog API provided by `dog.ceo`.

* **API Name**: Dog API
* **Base URL**: `https://dog.ceo/dog-api`
* **Authentication**: None required.
* **Rate Limits**: Not explicitly specified by the API documentation. Best practice is to use responsibly and implement caching to avoid excessive requests.
* **Common Response Structure**: Most endpoints return a JSON object with:
    * `message`: Contains the requested data (e.g., image URL, list of breeds).
    * `status`: A string indicating "success" or "error".

### Endpoints Used:

* **Get Random Dog Image (Any Breed)**
    * **Use Case**: Displaying a random dog on the Home Screen (US-0).
    * **Endpoint**: `GET /breeds/image/random`
    * **Purpose**: Fetches a URL for a random dog image from any breed.
    * **Response Example** (`status: "success"`):
        ```json
        {
            "message": "[https://images.dog.ceo/breeds/airedale/n02096051_1930.jpg](https://images.dog.ceo/breeds/airedale/n02096051_1930.jpg)",
            "status": "success"
        }
        ```
    * **Breed Name Parsing**: The breed name will be parsed from the message URL (e.g., "airedale" from the example above). This logic will reside in a utility function or mapper.

* **Get All Breeds List**
    * **Use Case**: Populating the Breed List screen (US-1).
    * **Endpoint**: `GET /breeds/list/all`
    * **Purpose**: Fetches a list of all dog breeds and their sub-breeds.
    * **Response Example** (`status: "success"`):
        ```json
        {
            "message": {
                "affenpinscher": [],
                "australian": ["kelpie", "shepherd"],
                "bulldog": ["boston", "english", "french"]
                // ... more breeds
            },
            "status": "success"
        }
        ```
    * **Data Processing**: This data will be transformed into a flat list of `BreedModel` objects, with display names like "Affenpinscher", "Australian Kelpie", "Australian Shepherd", etc., and corresponding API request paths (e.g., `affenpinscher`, `australian/kelpie`).

* **Get Random Image for a Specific Breed**
    * **Use Case**: Displaying images on the Breed Image screen (US-2).
    * **Endpoint**: `GET /breed/{breed_path}/images/random`
        * `{breed_path}`: The API request path for the breed (e.g., `affenpinscher`, `australian/kelpie`). This path is derived from `BreedModel.apiRequestPath`.
    * **Purpose**: Fetches a URL for a random dog image of the specified breed.
    * **Response Example** (`status: "success"`, for `hound/afghan`):
        ```json
        {
            "message": "[https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg](https://images.dog.ceo/breeds/hound-afghan/n02088094_1003.jpg)",
            "status": "success"
        }
        ```
* **Error Handling**:
    * The `DogApiProvider` will handle non-"success" statuses from the API and map them to domain-specific exceptions (e.g., `NetworkException`, `NoDataFoundException`).
    * Network connectivity issues (e.g., no internet) will be detected by a `ConnectivityService` and handled gracefully, often by attempting to load cached data or informing the user.

## 5. Git Flow Description

To manage the development lifecycle effectively, the project will adopt the Gitflow Workflow. This workflow defines a strict branching model designed around project releases.

### Main Branches:

* **main**: This branch will always reflect a production-ready state. It will only contain tagged releases. Merges to `main` primarily come from `release` branches or `hotfix` branches. Direct commits to `main` are prohibited.
* **develop**: This is the main integration branch for features. It reflects the latest delivered development changes for the next release. All feature branches are merged into `develop`.

### Supporting Branches:

* **Feature Branches** (`feature/<feature-name>`):
    * **Purpose**: For developing new features or user stories. Each user story (e.g., `us-0-home-screen`, `us-7-dark-theme`) should correspond to a feature branch.
    * **Branched off from**: `develop`
    * **Merged back into**: `develop` (via a Pull Request)
    * **Naming Convention**: `feature/usX-<short-description>` (e.g., `feature/us0-home-screen`) or `feature/<descriptive-name>` (e.g., `feature/add-breed-caching`).
    * **Lifetime**: Exists as long as the feature is in development. Deleted after merging into `develop`.
* **Release Branches** (`release/<version>`):
    * **Purpose**: To prepare for a new production release. This branch allows for final bug fixes, documentation generation, and other release-oriented tasks without disrupting the `develop` branch. No new features are added here.
    * **Branched off from**: `develop` (when `develop` is feature-complete for the release)
    * **Merged back into**: `main` (tagged) AND `develop` (to incorporate any last-minute fixes made in the release branch)
    * **Naming Convention**: `release/vX.Y.Z` (e.g., `release/v1.0.0`).
    * **Lifetime**: Exists until the release is deployed. Deleted after merging to `main` and `develop`.
* **Hotfix Branches** (`hotfix/<fix-name>`):
    * **Purpose**: To address critical bugs in a production release urgently.
    * **Branched off from**: `main` (from the corresponding tagged version)
    * **Merged back into**: `main` (new tag) AND `develop` (to ensure the fix is included in ongoing development)
    * **Naming Convention**: `hotfix/issue-<issue-number>` or `hotfix/<descriptive-name>` (e.g., `hotfix/home-screen-crash`).
    * **Lifetime**: Short-lived; exists only to fix the specific production issue.

### Tagging:

* Each merge into `main` (from a `release` or `hotfix` branch) must be tagged with a semantic version number (e.g., `v1.0.0`, `v1.0.1`, `v1.1.0`).

### Commit Messages:

* Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification (e.g., `feat: implement home screen random image`, `fix: resolve breed list search error`, `docs: update README`). This facilitates automated changelog generation and clearer history.
* **Example types**: `feat`, `fix`, `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test`.

### Pull Requests (PRs):

* All merges into `develop` and `main` (from feature, release, or hotfix branches) must be done via Pull Requests.
* PRs should clearly describe the changes and reference related issues or user stories.
* Code reviews are mandatory for PRs into `develop` and `main`. At least one other developer should review and approve.
* Automated checks (linters, tests via CI/CD pipeline) must pass before a PR can be merged.

This Git workflow ensures a structured development process, isolates new development, facilitates collaboration, and maintains a clean and reliable production codebase.
