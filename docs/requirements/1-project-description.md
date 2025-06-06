# Pawsitive Vibe Finder - Project Overview

## Project Description
The "Pawsitive Vibe Finder" is a simple and delightful mobile application designed for dog enthusiasts. It allows users to browse different dog breeds, view random dog images, save their favorite images, and easily revisit recently viewed breeds.

---
## Project Purposes
The primary goals of this project are to:
* Provide a user-friendly platform for discovering and exploring various dog breeds.
* Offer an engaging way for users to view a wide variety of dog images.
* Allow users to personalize their experience by saving favorite images.
* Enable quick access to recently viewed content for a seamless user journey.
* Create a positive and enjoyable experience for dog lovers.

---
## Technical Stack

* **Programming Language**: Dart with the **Flutter** framework.
* **State Management**: **BLoC/Cubit** for managing application state, including first-launch status, Home Screen dynamic content, UI updates based on API responses, and business logic.
* **Navigation**: **auto\_route** package for declarative routing and navigation management.
* **Dependency Injection**: **get\_it** package for service locator pattern and managing dependencies.
* **API Integration**: Flutter's `http` package or a similar library (e.g., `dio`) for API calls, with proper error handling.
* **Local Storage**:
    * **`shared_preferences`**: For simple key-value storage such as user preferences (theme, language), the first-launch flag, and the list of recently viewed breeds (if stored as a simple list of strings/IDs).
    * **`drift`**: A reactive persistence library for Flutter and Dart (built on SQLite) for managing structured local data, such as caching the full breed list and storing favorite image URLs.
* **Image Handling**: `cached_network_image` package for fetching, displaying, and caching network images, including the random image on the HomePage.
* **Localization**: Flutter's built-in localization support with the `intl` package and ARB files.

---
## Non-Functional Requirements:

* **Performance**: The application should be responsive and load images quickly. List scrolling, animations, and state updates via BLoC should be smooth. Data retrieval from `drift` should be optimized.
* **Usability**: The UI should be intuitive, accessible, and easy to navigate using `auto_route`.
* **Scalability**: The architecture, leveraging BLoC for separation of concerns, `get_it` for dependency management, and `drift` for scalable local data storage, should allow for potential future expansions with reasonable effort.
* **Maintainability**: Code should be well-structured, documented, and follow Dart/Flutter best practices. BLoC patterns, `auto_route` generated code, and `drift`'s generated DAOs/tables should aid in maintainability.
* **Error Handling**: Graceful handling of API errors, network issues, and invalid data, providing clear feedback to the user. BLoCs will manage error states. Local database errors from `drift` should also be handled gracefully.
* **Platform Compatibility**: The application should function consistently and correctly on both iOS and Android platforms targeted by Flutter.

---
## Future Considerations (Out of Scope for Initial Release):

* User accounts for syncing favorites/preferences across devices.
* Adding more detailed breed information (history, temperament, size, etc.).
* User-submitted content (photos, comments).
* Advanced filtering/sorting options for the breed list (e.g., by size, temperament, origin).
* Integration with other pet-related services or information.
* Push notifications for new content or features.