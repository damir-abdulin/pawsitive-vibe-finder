# User Story 6
: "Guess the Breed" Quiz Game

**AS A** user
**I WANT TO** play a quiz game where I guess the breed of a displayed dog from multiple-choice options
**SO THAT I** can test my knowledge in a fun way and become better at identifying different dog breeds.

# Preconditions:

| ID | Description|
| -- | ----------|
| PRE-Q-1 | The user has launched the application and navigated to the "Guess the Breed" quiz feature from the navigation drawer. |
| PRE-Q-2 | The application has a cached list of all available dog breeds to use for generating quiz options. |
| PRE-Q-3 | The device has an active internet connection to fetch new, random images for the quiz questions. |

# Acceptance Criteria:

| ID | Description|
| -- | ----------|
| AC-Q-1 | The system shall provide access to the quiz via a "Guess the Breed" option in the navigation drawer. |
| AC-Q-2 | Upon starting a new quiz, the system shall display the main quiz screen. |
| AC-Q-2.1 | The quiz screen shall have an AppBar with the title "Guess the Breed" and a leading back arrow icon to exit the quiz and return to the previous screen. |
| AC-Q-2.2 | A UI element shall display the current score (e.g., "Score: 0") and the current question number (e.g., "1 / 10"). |
| AC-Q-3 | The system shall fetch a random dog image and its correct breed name by parsing the image URL. |
| AC-Q-3.1 | While the image is loading, a `CircularProgressIndicator` shall be displayed. |
| AC-Q-3.2 | The fetched image shall be displayed prominently on the screen. |
| AC-Q-4 | The system shall generate three incorrect breed names, chosen randomly from the master breed list, ensuring they are not the same as the correct answer. |
| AC-Q-5 | The system shall display four tappable buttons, each containing one breed name (the one correct answer and three incorrect answers). The order of these buttons shall be randomized for each question. |
| AC-Q-6 | When the user taps a breed name button: |
| AC-Q-6.1 | All four answer buttons shall become disabled to prevent multiple submissions. |
| AC-Q-6.2 | **IF** the selected answer is correct: <br> • The tapped button shall be highlighted with a success color (e.g., green). <br> • The user's score shall be incremented by one. |
| AC-Q-6.3 | **IF** the selected answer is incorrect: <br> • The tapped button shall be highlighted with an error color (e.g., red). <br> • The button corresponding to the correct answer shall be highlighted with a success color to provide feedback. |
| AC-Q-7 | After a brief delay (e.g., 1.5 seconds) to show the feedback, the system shall automatically load the next question or, if it's the final question, navigate to the score summary screen. |
| AC-Q-8 | After a predefined number of questions (e.g., 10), the system shall navigate to a score summary screen. |
| AC-Q-8.1 | The summary screen shall display the user's final score (e.g., "You scored 8 out of 10!"). |
| AC-Q-8.2 | The summary screen shall display a "Play Again" button to start a new quiz and a "Done" button to navigate back to the HomePage. |
| AC-Q-9 | **Offline Behavior:** If the user attempts to start a quiz while offline, a modal dialog shall appear with a message informing them an internet connection is required. |

# Fields Requirements

| ID | Field | Description |
| -- | ----- | ----------- |
| F-Q-1 | Image Display | Type: Image View (`CachedNetworkImage` widget)<br>Behavior: Displays the dog image for the current question. Shows a loading indicator while fetching. |
| F-Q-2 | Answer Buttons | Type: Button (x4)<br>Behavior: Tappable elements displaying breed names. Provide visual feedback upon tap and reveal correct/incorrect status. |

# Message Requirements:

| ID | Trigger | Message Text |
| -- | ------- | ------------------ |
| M-Q-1 | **IF** user initiates quiz while offline<br>**THEN** the system displays a popup | "You're offline! Please connect to the internet to start a new quiz." |
| M-Q-2 | Displayed on final score screen | "You scored [X] out of [Y]!" |
| M-Q-3 | Button text on final score screen | "Play Again" |
| M-Q-4 | Button text on final score screen | "Done" |