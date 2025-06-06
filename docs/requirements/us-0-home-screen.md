# User Story 0: Dynamic and Interactive Home Screen

**AS A** user
**I WANT TO** see a welcoming message on my first visit, and on subsequent visits, view and interact with a random dog image (including its breed name) using swipe gestures to like or see the next image, along with clear navigation options, with appropriate behavior in offline mode
**SO THAT I** feel welcomed and engaged with dynamic content, can easily access the app's main functions, and understand limitations when offline.

**Preconditions:**
* PRE-HS-1: The user has successfully launched the "Pawsitive Vibe Finder" application.
* PRE-HS-2: The application can determine its current network connectivity status (online/offline).

**Acceptance Criteria (Screen 0: HomePage):**
* AC-HS-1: The system shall display an AppBar at the top of the HomePage.
    * AC-HS-1.1: The AppBar should display the application title "Pawsitive Vibe Finder".
    * AC-HS-1.2: The AppBar should include a leading icon (e.g., a "hamburger" icon) on the left side to open the navigation drawer.
* AC-HS-2: The system shall check if it is the user's first time launching the application.
    * AC-HS-2.1: **First Launch Behavior**: If it is the first launch:
        * AC-HS-2.1.1: The system shall display a modal popup dialog with a welcome message (e.g., "Welcome to Pawsitive Vibe Finder! Get ready for some pawsitivity!").
        * AC-HS-2.1.2: The popup shall have a dismiss button (e.g., "Get Started!", "OK").
        * AC-HS-2.1.3: Upon dismissal of the popup, the system shall set a flag in local storage indicating that the first-launch sequence has been completed.
        * AC-HS-2.1.4: After the popup is dismissed, the main HomePage content (navigation options) should be visible. No random image is displayed on this very first view after popup dismissal.
    * AC-HS-2.2: **Subsequent Launches Behavior**: If it is not the first launch:
        * AC-HS-2.2.1: The system shall attempt to fetch a random dog image and determine its breed (e.g., by parsing the image URL from `dog.ceo/dog-api/breeds/image/random`).
        * AC-HS-2.2.2: The random image should be displayed in the center of the screen. Under the image, the system shall display the parsed breed name of the dog in the image.
        * AC-HS-2.2.3: While a new image and its breed name are loading (either initially or after a swipe, if online), a `CircularProgressIndicator` shall be displayed in the image and breed name area.
        * AC-HS-2.2.4: If an error occurs while fetching the image/breed name:
            * AC-HS-2.2.4.1: If the application is in offline mode (detected prior to fetch attempt or fetch fails due to no connection), the system shall attempt to display a previously cached random image and its breed name if available.
            * AC-HS-2.2.4.2: For other types of errors (e.g., API error when online, no cached image available, unable to parse breed), the system shall display a generic error icon in the image area, and the breed name area may be empty or show an error indicator. The rest of the HomePage (navigation options) should still be functional.
        * AC-HS-2.2.5: The displayed image shall scale to fit within its designated bounds without cropping (e.g., `BoxFit.contain`).
        * AC-HS-2.2.6: **Swipe Right Interaction (Like and Next)**:
            * AC-HS-2.2.6.1: The user shall be able to attempt to swipe right on the displayed random image.
            * AC-HS-2.2.6.2: If the application is **offline** when the swipe right is attempted:
                * AC-HS-2.2.6.2.1: The system shall display a modal popup dialog.
                * AC-HS-2.2.6.2.2: The popup shall contain a message instructing the user to turn on their internet connection to use this feature (e.g., "Please connect to the internet to discover more dogs!").
                * AC-HS-2.2.6.2.3: The current cached image (if one was displayed) remains visible behind the popup. No image change or like action occurs.
            * AC-HS-2.2.6.3: If the application is **online** when the swipe right is attempted:
                * AC-HS-2.2.6.3.1: Upon a successful swipe right, the system shall mark the current image as a favorite (persisting this choice locally, consistent with AC-FAV-1.1).
                * AC-HS-2.2.6.3.2: After marking as favorite, the system shall immediately attempt to fetch and display a new random dog image and its breed name.
        * AC-HS-2.2.7: **Swipe Left Interaction (Next Only)**:
            * AC-HS-2.2.7.1: The user shall be able to attempt to swipe left on the displayed random image.
            * AC-HS-2.2.7.2: If the application is **offline** when the swipe left is attempted:
                * AC-HS-2.2.7.2.1: The system shall display a modal popup dialog.
                * AC-HS-2.2.7.2.2: The popup shall contain a message instructing the user to turn on their internet connection to use this feature (e.g., "Please connect to the internet to discover more dogs!").
                * AC-HS-2.2.7.2.3: The current cached image (if one was displayed) remains visible behind the popup. No image change occurs.
            * AC-HS-2.2.7.3: If the application is **online** when the swipe left is attempted:
                * AC-HS-2.2.7.3.1: Upon a successful swipe left, the system shall immediately attempt to fetch and display a new random dog image and its breed name.
* AC-HS-3: The HomePage body shall always display clear navigation options to the core features of the application (visible below or alongside the interactive image area on subsequent launches, or after popup dismissal on first launch).
    * AC-HS-3.1: There should be a distinct, tappable element (e.g., button, card) to navigate to the "Explore Dog Breed List" (BreedListPage).
    * AC-HS-3.2: There should be a distinct, tappable element to navigate to "Manage Favorite Dog Images" (FavoritesPage).
* AC-HS-4: If the user taps the leading icon (hamburger) in the AppBar, the system should open a navigation drawer (consistent with AC-NAV-6).
* AC-HS-5: The HomePage should be visually consistent with the overall application theme (light/dark mode as per User Story 7).
* AC-HS-6: All interactive elements on the HomePage, including swipe gestures on the image, should provide clear visual feedback upon interaction (e.g., image movement during swipe, visual confirmation of like).
* AC-HS-7: Text and navigation elements should be localized according to the selected language (as per User Story 10), including the welcome popup message and any text related to the breed name display or offline notifications.

**Field Requirements:**
* (Not applicable beyond standard UI elements and image display areas)

**Message Requirements:**
* M-HS-1: Welcome popup message (First Launch): e.g., "Welcome to Pawsitive Vibe Finder! Get ready for some pawsitivity!" (Text should be translatable).
* M-HS-2: Button text for dismissing welcome popup: e.g., "Get Started!", "OK" (Text should be translatable).
* M-HS-3: Error message if random image fails to load on HomePage (Subsequent Launches, when generic error icon is shown and online): e.g., "Woof! Couldn't fetch a new friend. Please check your connection." (Text should be translatable).
* M-HS-4: (Optional, if breed parsing fails specifically but image loads) Message or indicator if breed name cannot be determined: e.g., "Breed: Unknown" or a placeholder.
* **M-HS-5**: Popup message for swipe attempt while offline: e.g., "Please connect to the internet to discover more dogs!" (Text should be translatable).
* **M-HS-6**: Button text for dismissing offline swipe popup: e.g., "OK" (Text should be translatable).
