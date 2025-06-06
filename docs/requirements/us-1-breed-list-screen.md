# User Story 1: Explore Dog Breed List

**AS A** user
**I WANT TO** browse a comprehensive and searchable list of all available dog breeds (based on a defined set)
**SO THAT I** can easily discover and select a specific breed for further exploration.

**Note on Breed List Source:** The application utilizes a defined list of dog breeds and their sub-breeds, as detailed in Appendix A. This list structure is based on the expected response from the `dog.ceo/dog-api/breeds/list/all` service endpoint.

**Preconditions:**
* PRE-BL-1: The user has successfully launched the "Pawsitive Vibe Finder" application and navigated to the Breed List feature (e.g., from the HomePage or drawer).
* PRE-BL-2: The application has loaded the defined list of dog breeds (see Appendix A). *(Initial population of this defined list might occur via an API call as described in original preconditions, or the list might be bundled with the application. This story assumes the list is available for display.)*


**Acceptance Criteria (Screen 1: BreedListPage):**
* AC-BL-1: The system shall display an AppBar at the top of the BreedListPage.
    * AC-BL-1.1: The AppBar should display the title "Dog Breeds".
    * AC-BL-1.2: The AppBar should include a leading icon (e.g., a "hamburger" icon) on the left side to open the navigation drawer.
    * AC-BL-1.3: The AppBar should include a search bar icon/widget (e.g., a magnifying glass icon) on the right side.
* AC-BL-2: Upon tapping the search icon, the system should reveal an interactive input field (search bar) within or below the AppBar for filtering the breed list.
    * AC-BL-2.1: The search bar should allow users to type text for filtering the displayed breed names (as listed in Appendix A, Table 2).
    * AC-BL-2.2: The filtering should occur in real-time as the user types, dynamically updating the displayed list.
    * AC-BL-2.3: The search functionality should be case-insensitive.
* AC-BL-3: The system should display a comprehensive, vertically scrollable list of all available dog breed display names (see Appendix A, Table 2).
    * AC-BL-3.1: The dog breed display names in the list should be sorted alphabetically by default.
    * AC-BL-3.2: Each breed display name in the list should be tappable, and tapping a breed name shall navigate the user to the BreedImagePage for that specific breed, using the corresponding API Request Path (see Appendix A, Table 2).
* AC-BL-4: If the application is fetching initial data to populate or update its defined breed list (e.g., on first app use after install if not bundled, or during a manual "update breeds" action if implemented), a `CircularProgressIndicator` should be displayed. *(This AC is more for the list population/update process rather than every view of the list if it's already loaded).*
* AC-BL-5: If the defined breed list is empty (e.g., initial load failed and no bundled/cached list) or if the search criteria result in no matches from the loaded list, the system should display an empty state.
    * AC-BL-5.1: The empty state should include a centered Icon (e.g., a sad dog or a bone with a cross).
    * AC-BL-5.2: The empty state should include a Text message (e.g., "Woof! No breeds found. Try adjusting your search or check your connection if list is empty.") to inform the user.
* AC-BL-6: If the user taps the leading icon (hamburger), the system should open a navigation drawer.

**Field Requirements (Search Bar - Implicit, but defined for clarity):**
* **Search Input Field**:
    * Type: Text Input
    * Behavior: Allows users to type text to filter the breed list.
    * Validation: No specific validation, but should handle empty input gracefully.
    * Default State: Empty, with a placeholder like "Search breeds...".

**Message Requirements:**
* M-BL-1: Error message if an attempt to fetch/update the defined breed list from the API fails (e.g., "Could not update breed list. Please check your internet connection and try again.").
* M-BL-2: Informational message if the search yields no results from the loaded list (e.g., "No breeds match your search.").
* M-BL-3: Informational message if the defined breed list itself is empty after an attempted load (e.g., "No breeds available at the moment. Please try again later or check for an app update.").

---
## Appendix A: Breed Data

This data is based on the structure from the `dog.ceo/dog-api/breeds/list/all` endpoint.

### Table 1: Main Breeds and Their Sub-breeds

| Main Breed      | Sub-breeds                       |
|-----------------|----------------------------------|
| affenpinscher   | (none)                           |
| african         | (none)                           |
| airedale        | (none)                           |
| akita           | (none)                           |
| appenzeller     | (none)                           |
| australian      | kelpie, shepherd                 |
| bakharwal       | indian                           |
| basenji         | (none)                           |
| beagle          | (none)                           |
| bluetick        | (none)                           |
| borzoi          | (none)                           |
| bouvier         | (none)                           |
| boxer           | (none)                           |
| brabancon       | (none)                           |
| briard          | (none)                           |
| buhund          | norwegian                        |
| bulldog         | boston, english, french          |
| bullterrier     | staffordshire                    |
| cattledog       | australian                       |
| cavapoo         | (none)                           |
| chihuahua       | (none)                           |
| chippiparai     | indian                           |
| chow            | (none)                           |
| clumber         | (none)                           |
| cockapoo        | (none)                           |
| collie          | border                           |
| coonhound       | (none)                           |
| corgi           | cardigan                         |
| cotondetulear   | (none)                           |
| dachshund       | (none)                           |
| dalmatian       | (none)                           |
| dane            | great                            |
| danish          | swedish                          |
| deerhound       | scottish                         |
| dhole           | (none)                           |
| dingo           | (none)                           |
| doberman        | (none)                           |
| elkhound        | norwegian                        |
| entlebucher     | (none)                           |
| eskimo          | (none)                           |
| finnish         | lapphund                         |
| frise           | bichon                           |
| gaddi           | indian                           |
| germanshepherd  | (none)                           |
| greyhound       | indian, italian                  |
| groenendael     | (none)                           |
| havanese        | (none)                           |
| hound           | afghan, basset, blood, english, ibizan, plott, walker |
| husky           | (none)                           |
| keeshond        | (none)                           |
| kelpie          | (none)                           |
| kombai          | (none)                           |
| komondor        | (none)                           |
| kuvasz          | (none)                           |
| labradoodle     | (none)                           |
| labrador        | (none)                           |
| leonberg        | (none)                           |
| lhasa           | (none)                           |
| malamute        | (none)                           |
| malinois        | (none)                           |
| maltese         | (none)                           |
| mastiff         | bull, english, indian, tibetan   |
| mexicanhairless | (none)                           |
| mix             | (none)                           |
| mountain        | bernese, swiss                   |
| mudhol          | indian                           |
| newfoundland    | (none)                           |
| otterhound      | (none)                           |
| ovcharka        | caucasian                        |
| papillon        | (none)                           |
| pariah          | indian                           |
| pekinese        | (none)                           |
| pembroke        | (none)                           |
| pinscher        | miniature                        |
| pitbull         | (none)                           |
| pointer         | german, germanlonghair           |
| pomeranian      | (none)                           |
| poodle          | medium, miniature, standard, toy |
| pug             | (none)                           |
| puggle          | (none)                           |
| pyrenees        | (none)                           |
| rajapalayam     | indian                           |
| redbone         | (none)                           |
| retriever       | chesapeake, curly, flatcoated, golden |
| ridgeback       | rhodesian                        |
| rottweiler      | (none)                           |
| saluki          | (none)                           |
| samoyed         | (none)                           |
| schipperke      | (none)                           |
| schnauzer       | giant, miniature                 |
| segugio         | italian                          |
| setter          | english, gordon, irish           |
| sharpei         | (none)                           |
| sheepdog        | english, indian, shetland        |
| shiba           | (none)                           |
| shihtzu         | (none)                           |
| spaniel         | blenheim, brittany, cocker, irish, japanese, sussex, welsh |
| spitz           | indian, japanese                 |
| springer        | english                          |
| stbernard       | (none)                           |
| terrier         | american, australian, bedlington, border, cairn, dandie, fox, irish, kerryblue, lakeland, norfolk, norwich, patterdale, russell, scottish, sealyham, silky, tibetan, toy, welsh, westhighland, wheaten, yorkshire |
| tervuren        | (none)                           |
| vizsla          | (none)                           |
| waterdog        | spanish                          |
| weimaraner      | (none)                           |
| whippet         | (none)                           |
| wolfhound       | irish                            |

---
### Table 2: Display Breed Name and API Request Path

*(The table below will use the pattern: `Sub-breed Name Main-breed Name` for sub-breeds, and `Main-breed Name` for main breeds without sub-breeds. Single word main breeds like `germanshepherd` will be converted to "German Shepherd" for display.)*

| Display Breed Name        | API Request Path          |
|---------------------------|---------------------------|
| Affenpinscher             | affenpinscher             |
| African                   | african                   |
| Airedale                  | airedale                  |
| Akita                     | akita                     |
| Appenzeller               | appenzeller               |
| Australian Kelpie         | australian/kelpie         |
| Australian Shepherd       | australian/shepherd       |
| Indian Bakharwal          | bakharwal/indian          |
| Basenji                   | basenji                   |
| Beagle                    | beagle                    |
| Bluetick                  | bluetick                  |
| Borzoi                    | borzoi                    |
| Bouvier                   | bouvier                   |
| Boxer                     | boxer                     |
| Brabancon                 | brabancon                 |
| Briard                    | briard                    |
| Norwegian Buhund          | buhund/norwegian          |
| Boston Bulldog            | bulldog/boston            |
| English Bulldog           | bulldog/english           |
| French Bulldog            | bulldog/french            |
| Staffordshire Bullterrier | bullterrier/staffordshire |
| Australian Cattledog      | cattledog/australian      |
| Cavapoo                   | cavapoo                   |
| Chihuahua                 | chihuahua                 |
| Indian Chippiparai        | chippiparai/indian        |
| Chow                      | chow                      |
| Clumber                   | clumber                   |
| Cockapoo                  | cockapoo                  |
| Border Collie             | collie/border             |
| Coonhound                 | coonhound                 |
| Cardigan Corgi            | corgi/cardigan            |
| Cotondetulear             | cotondetulear             |
| Dachshund                 | dachshund                 |
| Dalmatian                 | dalmatian                 |
| Great Dane                | dane/great                |
| Swedish Danish            | danish/swedish            |
| Scottish Deerhound        | deerhound/scottish        |
| Dhole                     | dhole                     |
| Dingo                     | dingo                     |
| Doberman                  | doberman                  |
| Norwegian Elkhound        | elkhound/norwegian        |
| Entlebucher               | entlebucher               |
| Eskimo                    | eskimo                    |
| Lapphund Finnish          | finnish/lapphund          |
| Bichon Frise              | frise/bichon              |
| Indian Gaddi              | gaddi/indian              |
| German Shepherd           | germanshepherd            |
| Indian Greyhound          | greyhound/indian          |
| Italian Greyhound         | greyhound/italian         |
| Groenendael               | groenendael               |
| Havanese                  | havanese                  |
| Afghan Hound              | hound/afghan              |
| Basset Hound              | hound/basset              |
| Blood Hound               | hound/blood               |
| English Hound             | hound/english             |
| Ibizan Hound              | hound/ibizan              |
| Plott Hound               | hound/plott               |
| Walker Hound              | hound/walker              |
| Husky                     | husky                     |
| Keeshond                  | keeshond                  |
| Kelpie                    | kelpie                    |
| Kombai                    | kombai                    |
| Komondor                  | komondor                  |
| Kuvasz                    | kuvasz                    |
| Labradoodle               | labradoodle               |
| Labrador                  | labrador                  |
| Leonberg                  | leonberg                  |
| Lhasa                     | lhasa                     |
| Malamute                  | malamute                  |
| Malinois                  | malinois                  |
| Maltese                   | maltese                   |
| Bull Mastiff              | mastiff/bull              |
| English Mastiff           | mastiff/english           |
| Indian Mastiff            | mastiff/indian            |
| Tibetan Mastiff           | mastiff/tibetan           |
| Mexican Hairless          | mexicanhairless           |
| Mix                       | mix                       |
| Bernese Mountain          | mountain/bernese          |
| Swiss Mountain            | mountain/swiss            |
| Indian Mudhol             | mudhol/indian             |
| Newfoundland              | newfoundland              |
| Otterhound                | otterhound                |
| Caucasian Ovcharka        | ovcharka/caucasian        |
| Papillon                  | papillon                  |
| Indian Pariah             | pariah/indian             |
| Pekinese                  | pekinese                  |
| Pembroke                  | pembroke                  |
| Miniature Pinscher        | pinscher/miniature        |
| Pitbull                   | pitbull                   |
| German Pointer            | pointer/german            |
| Germanlonghair Pointer    | pointer/germanlonghair    |
| Pomeranian                | pomeranian                |
| Medium Poodle             | poodle/medium             |
| Miniature Poodle          | poodle/miniature          |
| Standard Poodle           | poodle/standard           |
| Toy Poodle                | poodle/toy                |
| Pug                       | pug                       |
| Puggle                    | puggle                    |
| Pyrenees                  | pyrenees                  |
| Indian Rajapalayam        | rajapalayam/indian        |
| Redbone                   | redbone                   |
| Chesapeake Retriever      | retriever/chesapeake      |
| Curly Retriever           | retriever/curly           |
| Flatcoated Retriever      | retriever/flatcoated      |
| Golden Retriever          | retriever/golden          |
| Rhodesian Ridgeback       | ridgeback/rhodesian       |
| Rottweiler                | rottweiler                |
| Saluki                    | saluki                    |
| Samoyed                   | samoyed                   |
| Schipperke                | schipperke                |
| Giant Schnauzer           | schnauzer/giant           |
| Miniature Schnauzer       | schnauzer/miniature       |
| Italian Segugio           | segugio/italian           |
| English Setter            | setter/english            |
| Gordon Setter             | setter/gordon             |
| Irish Setter              | setter/irish              |
| Sharpei                   | sharpei                   |
| English Sheepdog          | sheepdog/english          |
| Indian Sheepdog           | sheepdog/indian           |
| Shetland Sheepdog         | sheepdog/shetland         |
| Shiba                     | shiba                     |
| Shihtzu                   | shihtzu                   |
| Blenheim Spaniel          | spaniel/blenheim          |
| Brittany Spaniel          | spaniel/brittany          |
| Cocker Spaniel            | spaniel/cocker            |
| Irish Spaniel             | spaniel/irish             |
| Japanese Spaniel          | spaniel/japanese          |
| Sussex Spaniel            | spaniel/sussex            |
| Welsh Spaniel             | spaniel/welsh             |
| Indian Spitz              | spitz/indian              |
| Japanese Spitz            | spitz/japanese            |
| English Springer          | springer/english          |
| St Bernard                | stbernard                 |
| American Terrier          | terrier/american          |
| Australian Terrier        | terrier/australian        |
| Bedlington Terrier        | terrier/bedlington        |
| Border Terrier            | terrier/border            |
| Cairn Terrier             | terrier/cairn             |
| Dandie Terrier            | terrier/dandie            |
| Fox Terrier               | terrier/fox               |
| Irish Terrier             | terrier/irish             |
| Kerryblue Terrier         | terrier/kerryblue         |
| Lakeland Terrier          | terrier/lakeland          |
| Norfolk Terrier           | terrier/norfolk           |
| Norwich Terrier           | terrier/norwich           |
| Patterdale Terrier        | terrier/patterdale        |
| Russell Terrier           | terrier/russell           |
| Scottish Terrier          | terrier/scottish          |
| Sealyham Terrier          | terrier/sealyham          |
| Silky Terrier             | terrier/silky             |
| Tibetan Terrier           | terrier/tibetan           |
| Toy Terrier               | terrier/toy               |
| Welsh Terrier             | terrier/welsh             |
| Westhighland Terrier      | terrier/westhighland      |
| Wheaten Terrier           | terrier/wheaten           |
| Yorkshire Terrier         | terrier/yorkshire         |
| Tervuren                  | tervuren                  |
| Vizsla                    | vizsla                    |
| Spanish Waterdog          | waterdog/spanish          |
| Weimaraner                | weimaraner                |
| Whippet                   | whippet                   |
| Irish Wolfhound           | wolfhound/irish           |
