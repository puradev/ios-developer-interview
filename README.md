#  Hello

Welcome to the Pura Interview Process. Thank you for taking the time and we look forward to talking with you more.

### Task
We would like you to take this sample app and improve it in some way. The project is open ended but feel free to follow any #suggestions

Please take 2-4 hours to plan and make your improvements. Please fork this into your own public repository, make your changes, and submit a PR in your repo with your changes. (this prevents other candidates from easily viewing your changes) Then share the repository for review. 

### Purpose of Task
We want to see how you interact with an existing codebase.

A few things we will consider:
- Code Style, Quality, and Understandability
- Does it work?


Be prepared to talk about which improvements you made and why you made them in the next interview.

Feel free to reach out with any questions. nateh@pura.com


### App
This is a simple app where you can type in a word and get definitions for that word

### API

We are using a public api provided by Merriam Webster.

The Dictionary API is found [here](https://dictionaryapi.com/products/api-collegiate-dictionary)

and Documentation can be found [here](https://dictionaryapi.com/products/json)

### Suggestions
- Improve the user experience
- Add Views and experience For Thesaurus. `Tokens.apiKeyThes`
- Unit Tests or UI Tests
- view for empty state
- Error handling and display Errors to user
- Refactor to SwiftUI
- Refactor to Combine
- Add an easter egg or something to make us laugh
    - Giphy of the searched word
    - Konami Code

# Updates

## Summary of changes made
- Made network request use async/await to use more updated asynchronous capabilities, more readable code, and better internal management of thread resources.
- Created ViewModel to handle network request to fetch data and trigger UI changes using MVVM pattern
- Used Combine to bind and update UI from the viewModel to the ViewController
- Handled Error states
    - Empty state to prompt user to search for a word
    - Button disabled with hint t word is at least 3 characters long
    - Invalid error message if word is incorrect
- Improved user experience
    - Keyboard dismissal if search button tapped, from done button on keyboard, and also on tapping outside the keyboard.
    - Content is not hidden and clearly visible to the user
    - Definitions are displayed as a numbered list
    - Easy to follow instructions and hints through visibility and readability of messages and app states
    - Beautification with gradient background
- Added unit test for decoding JSON response

## Further improvements possible
- Add more unit tests, for example to mock network request.
- Can be updated to SwiftUI
- Can be made more attractive by adding assets and animations
- Can include a loading page for slower network requests
- Can include a landing page
- Can include additional settings to utilize more information from the JSON, for example, show related words from the stems list, disable or provide a warning for offensive words, etc.
