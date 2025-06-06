# User Story 4: View Recently Viewed Breeds

**AS A** user
**I WANT TO** see a list of dog breeds I recently viewed
**SO THAT I** can quickly navigate back to them without searching again.

**Preconditions:**
* PRE-RV-1: The user has previously navigated to at least one BreedImagePage.

**Acceptance Criteria (Accessed via Navigation Drawer):**
* AC-RV-1: The system shall maintain and manage a list of recently viewed dog breeds with the following behaviors:
    * AC-RV-1.1: The list shall store a defined number of the most recently viewed breeds (a maximum of 10 breeds).
    * AC-RV-1.2: When a breed's `BreedImagePage` is navigated to (triggering it as "viewed"):
        * AC-RV-1.2.1: If the breed is already present in the 'Recently Viewed' list, it is moved to the top of the list (marked as the most recently viewed), and its entry is not duplicated.
        * AC-RV-1.2.2: If the breed is not already in the list, it is added to the top of the list as the most recently viewed.
        * AC-RV-1.2.3: If adding a new breed (as per AC-RV-1.2.2) causes the list to exceed its defined maximum limit (e.g., 10 breeds), the least recently viewed breed (the one at the bottom of the list) is automatically removed.
* AC-RV-2: This list shall be accessible, for example, via a "Recently Viewed" section in the navigation drawer or a dedicated screen linked from the drawer.
    * AC-RV-2.1: If a dedicated screen is used, it should have an AppBar with the title "Recently Viewed" and a back arrow.
* AC-RV-3: The list should display the **'Display Breed Names' (as defined in User Story 1, Appendix A, Table 2)** of the recently viewed breeds, ordered from most recently viewed to least recently viewed.
* AC-RV-4: Tapping on a breed name in the "Recently Viewed" list navigates the user directly to the BreedImagePage for that specific breed (using its corresponding API Request Path).
* AC-RV-5: The list of recently viewed breeds (e.g., their API Request Paths and potentially Display Names for quick display) is persisted locally on the device.
* AC-RV-6: If no breeds have been viewed yet (i.e., the list is empty), an appropriate message is displayed.

**Message Requirements:**
* M-RV-1: Message for empty recently viewed list: "You haven't explored any breeds yet!"
