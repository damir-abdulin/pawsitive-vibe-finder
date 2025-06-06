# User Story 2: View and Interact with Images for a Specific Dog Breed via Swipes

**AS A** user who has selected a specific dog breed from the list
**I WANT TO** view random images of that particular breed and navigate through new random images of the same breed using swipe gestures, including the ability to mark an image as a favorite via a swipe
**SO THAT I** can enjoy a fluid visual exploration of my chosen dog breed and save images I like.

**Preconditions:**
* PRE-BSI-1: The user is currently on the BreedListPage and has successfully tapped on a valid dog breed name (using the API Request Path from Appendix A of User Story 1).
* PRE-BSI-2: The device has an active internet connection to fetch breed-specific images from the `dog.ceo/dog-api/breed/{breed_name}/images/random` endpoint (for initial load and swipe actions if online). (For offline mode, cache hits for previously viewed images might be used for initial display if applicable, but swipe actions to fetch *new* images will be restricted).
* PRE-BSI-3: The `dog.ceo/dog-api/breed/{breed_name}/images/random` endpoint is accessible and returning a valid JSON response containing a URL to a dog image when online.
* PRE-BSI-4: The selected dog breed's API request path is correctly passed to and used by the BreedImagePage for API calls.
* PRE-BSI-5: The application can determine its current network connectivity status (online/offline).

**Acceptance Criteria (Screen 2: BreedImagePage):**
* AC-BSI-1: The system should display an AppBar at the top of the BreedImagePage.
    * AC-BSI-1.1: The AppBar should display the name of the selected breed as its title (e.g., "Golden Retriever").
    * AC-BSI-1.2: The AppBar should include a leading back arrow icon on the left side, allowing the user to navigate back to the BreedListPage.
* AC-BSI-2: The system should display a central image widget to show a random dog image for the selected breed.
    * AC-BSI-2.1: While a new image is loading (either initially or after a swipe action when online), a `CircularProgressIndicator` should be displayed centrally over the image area.
* AC-BSI-3: Upon successful loading, the fetched image shall replace the loading indicator and be displayed in the designated image area.
    * AC-BSI-3.1: The displayed image shall be scaled to fill the bounds of its container, maintaining its aspect ratio. If the image's aspect ratio differs from the container's aspect ratio, the image will be cropped to fit (equivalent to `BoxFit.cover`).
* AC-BSI-4: If an image fails to load during the initial display (e.g., network error, invalid URL from API), the system should display an error state.
    * AC-BSI-4.1: The error state should include a placeholder icon (e.g., a broken image icon) or a generic placeholder image.
    * AC-BSI-4.2: The error state should be accompanied by an informative text message (e.g., "Image failed to load. Please check your connection or try again later.").
* AC-BSI-5: The system should handle cases where the API (on initial load) returns a response indicating no image is available for the specific breed.
    * AC-BSI-5.1: In such cases, the system should display an empty state with an appropriate icon and message (e.g., "No images found for this breed. Try another!"). Swipe gestures may be disabled in this state.
* AC-BSI-6: **Swipe Right Interaction (Like and Next Image for this Breed)**:
    * AC-BSI-6.1: The user shall be able to attempt to swipe right on the displayed random image.
    * AC-BSI-6.2: If the application is **offline** when the swipe right is attempted:
        * AC-BSI-6.2.1: The system shall display a modal popup dialog.
        * AC-BSI-6.2.2: The popup shall contain a message instructing the user to turn on their internet connection (e.g., "Please connect to the internet to discover more dogs!").
        * AC-BSI-6.2.3: The current image (if one was displayed) remains visible behind the popup. No image change or like action occurs.
    * AC-BSI-6.3: If the application is **online** when the swipe right is attempted:
        * AC-BSI-6.3.1: Upon a successful swipe right, the system shall mark the currently displayed image as a favorite (persisting this choice locally).
        * AC-BSI-6.3.2: After marking as favorite, the system shall immediately attempt to fetch and display another random image of the *same selected breed*.
        * AC-BSI-6.3.3: If fetching the new image via swipe fails, an appropriate error message or visual indicator should be shown in the image area, and the user might be able to attempt another swipe.
* AC-BSI-7: **Swipe Left Interaction (Next Image for this Breed Only)**:
    * AC-BSI-7.1: The user shall be able to attempt to swipe left on the displayed random image.
    * AC-BSI-7.2: If the application is **offline** when the swipe left is attempted:
        * AC-BSI-7.2.1: The system shall display a modal popup dialog.
        * AC-BSI-7.2.2: The popup shall contain a message instructing the user to turn on their internet connection (e.g., "Please connect to the internet to discover more dogs!").
        * AC-BSI-7.2.3: The current image (if one was displayed) remains visible behind the popup. No image change occurs.
    * AC-BSI-7.3: If the application is **online** when the swipe left is attempted:
        * AC-BSI-7.3.1: Upon a successful swipe left, the system shall immediately attempt to fetch and display another random image of the *same selected breed*.
        * AC-BSI-7.3.2: If fetching the new image via swipe fails, an appropriate error message or visual indicator should be shown in the image area, and the user might be able to attempt another swipe.
* AC-BSI-8: Visual feedback should be provided during swipe gestures (e.g., image movement).

**Message Requirements:**
* M-BSI-1: Error message if the API call to fetch the initial breed image fails (e.g., "Woof! Couldn't fetch image. Check your connection.").
* M-BSI-2: Error message if the API returns an invalid or broken image URL for the initial image (e.g., "Paws up! Image unavailable.").
* M-BSI-3: If the BreedImagePage is loaded without a valid `breed_name` parameter (e.g., direct navigation attempt without selection). "Oops! No breed selected. Please go back and pick one."
* M-BSI-4: If no images are found for the selected breed after a successful API call for initial load. "No images found for [Breed Name]. Try another breed!"
* M-BSI-5: Popup message for swipe attempt while offline: e.g., "Please connect to the internet to discover more dogs!" (Text should be translatable).
* M-BSI-6: Button text for dismissing offline swipe popup: e.g., "OK" (Text should be translatable).
* M-BSI-7: Error message if fetching a new image via swipe fails when online (e.g., "Could not load next image. Please try swiping again.").