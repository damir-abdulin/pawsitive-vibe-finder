# Requirements Review: US-0 Home Screen (2025-06-08) - *Updated*

## Overview

This document provides an updated review of the project's status against the requirements defined in **User Story 0: Dynamic and Interactive Home Screen** (`us-0-home-screen.md`).

After a full analysis of the codebase, it is clear that a substantial portion of the business logic for US-0 has been implemented in the `domain` and `presentation` (BLoC) layers. The application correctly handles the logic for the first-launch experience, fetching random dogs, caching, and responding to swipe gestures.

However, key features are either incomplete (mocked) or not yet fully connected to a working UI, preventing the user story from being considered "done."

## What will be checked

This review assesses the implementation of the following key areas from `us-o-home-screen.md`:
- **First Launch Experience:** Welcome popup and state persistence.
- **Subsequent Launches:** Display of a random dog image and breed name.
- **User Interaction:** Swipe gestures (like/next) and their corresponding online/offline logic.
- **UI Elements:** AppBar, navigation options, and loading/error indicators.
- **Offline Behavior:** Caching and user notifications.

## Compliance Status

Here is a breakdown of the current status of the acceptance criteria (AC).

- **AC-HS-1 (AppBar):** **Not Implemented.** No UI exists yet to display the AppBar.
- **AC-HS-2 (First/Subsequent Launch):** **Partially Implemented.**
    - `AC-HS-2.1` (First Launch): The logic is present in `HomeBloc` (`FirstLaunchState`), but there is no UI (modal popup) to show the welcome message. `SetFirstLaunchCompletedUseCase` is correctly used.
    - `AC-HS-2.2` (Subsequent Launches): The logic for fetching a random dog is implemented in `HomeBloc` and `GetRandomDogsUseCase`. Caching logic via `GetLastDogUseCase` is also present. However, there is no UI to display the image, breed name, or loading/error indicators.
- **AC-HS-2.2.6 (Swipe Right - Like):** **Partially Implemented.**
    - The `HomeBloc` correctly calls `SaveFavoriteDogUseCase` on a right swipe.
    - **CRITICAL FLAW:** The `FavoritesRepository` is a mock. The "like" is not persisted, so this functionality does not actually work.
- **AC-HS-2.2.7 (Swipe Left - Next):** **Implemented.** The `HomeBloc` correctly handles the logic for discarding the current dog and showing the next one from its internal list.
- **AC-HS-3 (Navigation Options):** **Not Implemented.** No UI exists to display the navigation elements.
- **AC-HS-4 & AC-HS-5 (Drawer & Theme):** **Implemented.** The overall app structure supports theming and a navigation router is in place, ready to be configured with a drawer.
- **AC-HS-6 & AC-HS-7 (Feedback & Localization):** **Partially Implemented.** The app has a localization setup, but no UI elements exist to apply the translations or visual feedback to.

## Disadvantages and Problems

1.  **Critical Feature is Mocked:** The single most significant problem is that the "like" feature is not functional. As detailed in the architecture and code reviews, the `FavoritesRepository` is a mock. This prevents `AC-HS-2.2.6.3.1` from being met.
2.  **Missing User Interface:** The primary blocker for completing this user story is the lack of a UI. While the `HomeBloc` correctly manages the state, there is no `HomeBody` widget that listens to these states and builds the corresponding UI (welcome dialog, image card, error messages, etc.).
3.  **Offline Handling for Swipes is Missing:** The `HomeBloc` does not currently check for network connectivity before attempting a swipe action. The user story requires a popup to be shown if the user tries to swipe while offline (`AC-HS-2.2.6.2` and `AC-HS-2.2.7.2`). The project already has a `ConnectivityService`, but it is not being used in the BLoC.

## Improvements

The path to completing US-0 is now very clear. The backend logic is mostly in place; the focus must shift to the UI and fixing the critical repository issue.

1.  **Implement the Favorites Repository:** This is the highest priority. Replace the mock `FavoritesRepositoryImpl` with a real implementation using the existing `drift` database setup. This will make the "like" feature fully functional.
2.  **Build the Home Screen UI:**
    - Create a `HomeBody` widget that uses a `BlocBuilder` to listen to the `HomeBloc`.
    - When the state is `FirstLaunchState`, use `WidgetsBinding.instance.addPostFrameCallback` to show a `showDialog` with the welcome message.
    - When the state is `SubsequentLaunchState`, display the dog image and breed name. Use a widget like `Dismissible` or a gesture detector to handle the swipe interactions, which will dispatch events to the `HomeBloc`.
    - When the state is `HomeLoading`, show a `CircularProgressIndicator`.
    - When the state is `HomeError`, show an appropriate error icon and message.
3.  **Integrate Connectivity Check:**
    - Inject the `ConnectivityService` into the `HomeBloc`.
    - In the `_handleSwipe` method, before doing anything else, check the connectivity status using `_connectivityService.isConnected`.
    - If offline, emit a new state like `ShowOfflineErrorPopup`, which the UI can listen for (using a `BlocListener`) to show the required dialog. Do not proceed with the rest of the swipe logic.

By completing these three steps, you will fully meet all the requirements for User Story 0 and have a complete, functional home screen. 