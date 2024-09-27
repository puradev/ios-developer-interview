#  Ben Patch Code Challenge
## Goals/Ideas

1. ✅ Make API use Async Await
2. ✅ Replace root view with SwiftUI
3. Implement UI
    - ✅ Search bar that opens ResultView
        - ✅ API.fetchWord
        - ✅ `WordResponse`
        - ✅ ResultView(WordResponse)
    - ✅ History below search bar
        - ✅ PersistantStore (err SwiftData version)
        - ✅ WordResponse -> @Model `SearchHistory`
        - ✅ @Query SearchHistory
        - ✅ ResultView(WordResponse) -> ResultView(SearchHistory)
    - ResultView saves and allows text input for "reasoning"
        - ✅ NavigationStack pushes ResultView 
        - SearchHistory.personalNote
        - Text Input UI
        - Save button/functionality
        - Cancel button/functionality
    - ResultView shows synnonyms of word
        - WordResponse.synonyms
        - SearchHistory.synonyms
        - Synonyms UI (add to scrollable list) 
    - ResultView shows Image of word
        - Gliffyx.getImages(String)
        - GliffyxResult
        - AsyncImage
        - Update ResultView with Image (in scrollable list)
        - SearchHistory.imageURL
        - Stretch goal:
            - Allow cycling between image results and save selected image to SearchHistory.imageURL (or save all of them)
    - Update ResultView to be fancy
        - Convert Scrollable list to 3 separate states
        - Add fancy button that allows you to drag between states
    
Dependencies:
SearchView
    - API.fetchWord
    - `save(SearchHistory)`
    - present(ResultView)
HistoryView
    - @Query history
    - present(ResultView)
ResultView (Definition, Synonyms, Images, Personal Note)
    - Gliffyx.getImages
    - `SearchHistory.definition`
    - `SearchHistory.synonyms`
    - SwiftData `.save()`


BUGS:
- search bar disappears if you select one of the history items when the keyboard is up
    - Fix this by implementing a custom search bar at the top of the View and get rid of the horrible .searchable api.

