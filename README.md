# Pawsitive Vibe Finder 🐾

A simple, delightful mobile application for dog enthusiasts to browse different dog breeds, view random dog images, save their favorite images, and easily revisit recently viewed breeds.

## Table of Contents
* [About The Project](#about-the-project)
* [Features](#features)
* [Architecture](#architecture)
* [Tech Stack](#tech-stack)
* [API Used](#api-used)
* [Getting Started](#getting-started)
    * [Prerequisites](#prerequisites)
    * [Installation](#installation)
    * [Running the Application](#running-the-application)
* [Git Workflow](#git-workflow)
* [Future Enhancements](#future-enhancements)
* [Contributing](#contributing)
* [License](#license)
* [Contact](#contact)

## About The Project

"Pawsitive Vibe Finder" aims to provide a user-friendly mobile experience for dog lovers. Users can explore a comprehensive list of dog breeds, delve into random images of specific breeds, save their favorite discoveries, and keep track of their recently viewed breeds. The application is built with a focus on a clean, intuitive UI/UX, offline capabilities, and a modern dark theme.

## Features

The application implements the following core functionalities:

* **Explore Dog Breed List**: Browse a searchable and sortable list of all available dog breeds.
* **View Random Images for a Specific Dog Breed**: View random images for a selected breed, with options to refresh and favorite.
* **View a Global Random Dog Image**: Get a quick dose of "pawsitive" content with a completely random dog image from any breed, also with refresh and favorite options.
* **Manage Favorite Dog Images**: Save and revisit favorite dog images locally.
* **View Recently Viewed Breeds**: Access a list of recently viewed dog breeds for quick navigation.
* **Navigation**: Seamlessly navigate between different screens of the application.
* **Application Consistency and User Experience**: Maintains a clear, consistent, and intuitive UI/UX across all screens.
* **Dark Theme Support**: Allows users to switch between light and dark visual themes for comfortable use.
* **Offline Mode/Caching**: View previously fetched dog breeds and images even without an active internet connection.
* **Animations**: Provides smooth and visually appealing transitions and interactions for a modern and polished feel.
* **Localization**: Supports multiple languages (English, Spanish, German, French) for user-facing text.

## Architecture

The "Pawsitive Vibe Finder" adheres to **Clean Architecture principles**, designed for scalability, maintainability, and testability. It strictly divides the software into layers with specific responsibilities, ensuring separation of concerns.

The primary layers are:
* **domain**: Contains the core business logic and abstractions, independent of UI or data storage.
* **data**: Implements repository interfaces from the domain layer and handles interactions with external data sources (APIs, local storage).
* **presentation**: Responsible for the User Interface and user interaction, built with Flutter, utilizing BLoC for state management.
* **di**: Manages centralized dependency injection using `get_it`.

This layered approach promotes:
* **Testability**: Each layer can be tested independently.
* **Maintainability & Scalability**: Changes in one layer have minimal impact on others.

## Tech Stack

The project is built using Flutter and leverages the following key packages:

* **`dio`**: For robust HTTP client and API integration.
* **`flutter_bloc`**, **`bloc`**: For predictable state management.
* **`get_it`**: For streamlined dependency injection.
* **`auto_route`**: For declarative and type-safe routing.
* **`drift`**: For structured local SQLite database persistence and caching.
* **`shared_preferences`**: For lightweight local key-value storage of user preferences and recently viewed items.
* **`cached_network_image`**: For efficient image loading and caching from the network.
* **`intl`**: For internationalization and localization support.
* **`connectivity_plus`**: To monitor network connectivity status.
* **`sqlite3_flutter_libs`**, **`path_provider`**: Companion packages for Drift database functionality.
* **`json_annotation`**: For JSON serialization annotations.

**Development Dependencies (for code generation)**:
* **`build_runner`**: Tool for running code generators.
* **`json_serializable`**: Generates `fromJson`/`toJson` methods for data models.
* **`drift_dev`**: Generates database code for Drift.
* **`auto_route_generator`**: Generates route code for AutoRoute.

## API Used

The application primarily interacts with the **Dog API** provided by `dog.ceo`.

* **API Name**: Dog API
* **Base URL**: `https://dog.ceo/dog-api`
* **Authentication**: None required.
* **Purpose**: Fetches lists of dog breeds and random images, both globally and per breed.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

* Flutter SDK installed ([Flutter Installation Guide](https://flutter.dev/docs/get-started/install))
* A code editor like VS Code or Android Studio.

### Installation

1.  Clone the repository:
    ```bash
    git clone [https://github.com/your-username/pawsitive_vibe_finder.git](https://github.com/your-username/pawsitive_vibe_finder.git)
    ```
    (Replace `your-username` with the actual repository owner)
2.  Navigate to the project directory:
    ```bash
    cd pawsitive_vibe_finder
    ```
3.  Install Flutter dependencies:
    ```bash
    flutter pub get
    ```
4.  Run code generation (for `json_serializable`, `drift`, `auto_route`):
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Running the Application

1.  Connect a device or start an emulator.
2.  Run the application:
    ```bash
    flutter run
    ```

## Git Workflow

This project adopts the **Gitflow Workflow** to manage its development lifecycle, ensuring a structured approach to releases and features.

* **`main` branch**: Reflects production-ready code, containing only tagged releases.
* **`develop` branch**: The main integration branch for ongoing feature development, reflecting the latest changes for the next release.
* **`feature/<name>` branches**: For developing new features, branched from `develop` and merged back into `develop` via Pull Requests.
* **`release/<version>` branches**: Used to prepare for new production releases, branched from `develop` and merged into `main` and `develop`.
* **`hotfix/<name>` branches**: For urgent production bug fixes, branched from `main` and merged back into `main` and `develop`.

All commit messages adhere to the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification. Pull Requests are mandatory for merging into `develop` and `main`, requiring code reviews and passing automated checks.

## Future Enhancements

The following features are considered out of scope for the initial release but are potential future considerations:
* User accounts for syncing favorites/preferences across devices.
* Adding more detailed breed information (history, temperament, size, etc.).
* User-submitted content (photos, comments).
* Advanced filtering/sorting options for the breed list (e.g., by size, temperament, origin).
* Integration with other pet-related services or information.
* Push notifications for new content or features.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

Please ensure your pull requests align with the Gitflow Workflow and Conventional Commits standards.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contact

Your Name - your.email@example.com
Project Link: [https://github.com/your-username/pawsitive_vibe_finder](https://github.com/your-username/pawsitive_vibe_finder)
