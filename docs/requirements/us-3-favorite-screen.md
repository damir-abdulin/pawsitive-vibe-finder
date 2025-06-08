# User Story 3: Manage Favorite Dog Images

**AS A** user
**I WANT TO** save my favorite dog images and view them later, with the ability to manage them within a dedicated favorites screen
**SO THAT I** can easily access and curate the images I like the most.

**Preconditions:**
* PRE-FAV-1: The application is running.
* PRE-FAV-2: For viewing/managing favorites, the user has navigated to the Favorites feature (FavoritesPage).

**Acceptance Criteria:**

* **AC-FAV-1: Mechanism for Adding to Favorites & Status Indication on Image Viewing Screens:**
    * AC-FAV-1.1: Images are added to the user's local list of favorites when the user performs a 'like' action (e.g., swipe right) on an image displayed on the Home Screen (as per User Story 0) or on the BreedImagePage (as per User Story 2).
    * AC-FAV-1.2: When an image that is already in the user's favorites list is displayed on the Home Screen or BreedImagePage, a clear visual indicator (e.g., a small, persistent heart icon overlay) shall be present to denote its favorited status.

* **AC-FAV-2: Favorites Page Access and Structure (Screen: FavoritesPage):**
    * AC-FAV-2.1: There should be a dedicated "Favorites" screen (FavoritesPage) accessible from the navigation drawer and/or HomePage.
    * AC-FAV-2.2: The FavoritesPage should have an AppBar with the title "Favorite Images" and a back arrow.

* **AC-FAV-3: Display of Favorite Images on FavoritesPage:**
    * AC-FAV-3.1: The FavoritesPage shall display all locally saved favorite images in a **grid view**.
    * AC-FAV-3.2: Each image item in the grid shall display the dog image.
    * AC-FAV-3.3: Each image item in the grid shall have an icon button with a **filled heart** displayed, aligned to the bottom-left of the image.

* **AC-FAV-4: Interaction with Favorite Images on FavoritesPage:**
    * AC-FAV-4.1: Tapping the filled heart icon button on an image item in the grid shall:
        * AC-FAV-4.1.1: Update the image's status to "not favorite" in local storage.
        * AC-FAV-4.1.2: Change the icon button on that specific item to an **outlined heart**.
        * AC-FAV-4.1.3: The image item temporarily remains visible in the grid with the outlined heart.
    * AC-FAV-4.2: Tapping the outlined heart icon button (on an item that was just un-favorited as per AC-FAV-4.1) shall:
        * AC-FAV-4.2.1: Update the image's status back to "favorite" in local storage.
        * AC-FAV-4.2.2: Change the icon button on that specific item back to a **filled heart**.
    * AC-FAV-4.3: Tapping any part of the image in the grid item (other than the heart icon specifically, if design allows separate tap targets) may navigate to a larger, full-screen view of the image. This larger view does not offer favoriting/unfavoriting actions itself; management is done via the heart icon on the grid. *(This clarifies that the primary interaction for favoriting status change is the icon on the grid.)*

* **AC-FAV-5: FavoritesPage Content Integrity:**
    * AC-FAV-5.1: When the FavoritesPage is loaded or reloaded (e.g., by navigating to it, or returning to it after navigating away), it must only display images that are currently marked as "favorite" in local storage.
    * AC-FAV-5.2: Any image that was set to "not favorite" (icon changed to outlined heart) and not subsequently re-favorited during the user's interaction on the page (as per AC-FAV-4.2) will not be displayed upon reloading/re-navigating to the FavoritesPage.

* **AC-FAV-6: Empty State for FavoritesPage:**
    * AC-FAV-6.1: If no images have been favorited and persisted, the FavoritesPage displays an appropriate message (e.g., "No favorite woofers yet! Swipe right on an image you like to save it here.").

* **AC-FAV-7: Persistence of Favorites:**
    * AC-FAV-7.1: The list of favorite image URLs (or identifiers) is persisted locally on the device (e.g., using `drift` as specified in the technical stack).

**Message Requirements:**
* M-FAV-1: Visual feedback (e.g., heart icon animation) is preferred over text messages when an image's favorite status is changed via swipe (on US0/US2) or icon tap (on FavoritesPage).
* M-FAV-2: Message for empty favorites list: "No favorite woofers yet! Swipe right on an image you like to save it here."