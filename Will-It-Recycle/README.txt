Beta Release Document - Team 10

Important Notes: Our app should be run with the simulator set to an iPhone 11 Pro Max, as this is what we designed it for.

Github repo: https://github.com/varshinees/will-it-recycle-austin


Contributions: A detailed description of what each team member contributed to this release, including a list of what features and/or functions he or she worked on. 

Chelsie Barrientos (25%):
App:
- Added app notifications
Settings:
- Displayed the current user’s name and current leaves
- Added functionality for the user to update their username and email address
- Added functionality for the user to change app notifications settings with alerts
- Added functionality for the user to opt in/out of the leaderboard through leaderboard settings with alerts
- Added functionality for the user to delete their account and redirecting them to the initial login/signup screen if they choose to do so
Dashboard:
- Displayed the current user’s name, current leaves, and all time leaves
- Implemented leaderboard which displays the top five users with the most leaves of all time
- Designed the leaderboard to display trophies for the 1st, 2nd, and 3rd place users
- Displayed the all time leaves of the top five users
Welcome:
- Added segue back to Settings screen when the user wishes to change their avatar

Katherine Hsu (25%): 
Store: 
- Created a local store array that stores all store items to display on the table
- On “BUY” button, the desired item will be added to user’s inventory in Firebase, and the item will also be added to the local inventory array
- Created alert that states whether the user has successfully purchased an item or if an error occurred because the user doesn’t have enough leaves
- Display user’s number of leaves
Game Screen: 
- Displayed images for items that the user has placed on the game screen by looping through gameItem objects in the local active items array (which is populated during login)
- Display user’s number of leaves

Victoria Denney (25%):
Inventory Screen:
- Loaded inventory and activeItems from user to create local arrays made up of gameItem objects containing key, itemName, count, and coordinates fields
- Populated table view with inventory list 
- On “PLACE” button, user is segued to placement grid screen, inventory table view is dynamically updated, and both local and firebase inventory arrays are modified, decrementing the count or removing the item altogether
Placement Grid Screen: 
- Built placement grid UI
- Created occupiedCoordinate local array of coordinates where items are already placed on the game screen 
- Produced the placement grid, in which cells greys out are the ones included in the occupiedCoordinate, thus these buttons are disabled to prohibit the user from overlapping game items
- On “CONTINUE,” the selected cell coordinate is added to local and firebase activeItems arrays, and occupiedCoordinates, otherwise an alert appears 

Varshinee Sreekanth (25%):
Firebase setup:
- Set up Firebase Realtime Database to store and retrieve user information and integrated it with the app.
Recycle screen:
- Allowed for the user to enter quantities in text fields and redeem them for leaves
- Updated Firebase’s database with the item, quantity, and date for each redemption
- Added error checking for this entire screen
Recycle History:
- Implemented functionality for this screen where upon loading it’ll retrieve the recycled items from Firebase and populate the table with them.


Differences: explanations of any deviation between what is being submitted in this release and what was previously committed in the proposal paper. For each deviation, explain why it occurred.

- Leaderboard - our UI changed slightly since we realized that having sliders was not as useful as having the actual number of leaves people earned.
- Recycle Scan Screen - we got rid of the barcode scanning capacity because barcodes don’t actually store information about recycling. We’ve already talked about this in a meeting with you and decided to focus on the rest of the app.
- Game screen - We added another screen, the Grid Screen, to help the user place an item onto their piece of land. This screen was deemed necessary for a smooth user experience.


Things left to do for the final release:
(These are not deviations, simply a to-do list and so you know what we still have left. Our proposal allows for these all to not be completed until the final release.)

Login:
- Get rid of “Cancel” button
Game:
- Back button from the grid screen
- “Remove Item” functionality
- Overall cleanup of look
- Search bar functionality for store
- Pictures for store
- “Claim daily rewards” functionality
Recycle screen:
- Search bar functionality
Dashboard:
- Fix bug where if the user changes their username in Settings, the changes don’t - translate to the Dashboard until the user closes the app and opens it again
- Implementing the user’s status card
- Adding segues to the “Redeem Leaves” and “Recycle Items Now” buttons
Welcome:
- Allowing the user to choose their avatar
Settings:
- Allowing the user to change their avatar
- Storing the user’s current avatar
Overall:
- Tighten up the look and feel of the app
- Fine tune design and add more razzle dazzle

