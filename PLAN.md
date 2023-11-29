# Plan of Attack

This is the scope of the work I'm hoping to accomplish.

~~1. Resolve errors for fetching~~

> So nothing was wrong, on my initial test, after viewing docs, the request can only have a single word. But this is a solid improvment we can add

- Add extensions for JSON Printing for utility & debugging
- Add Logging to requests

2. Update networking to use Async/Await
   > First iteration added this to the UIKit version of the app

- Use `Codable` and generics to handle JSON parsing rather than manual methods

3. Utilize SwiftUI and TCA
   > Added the feature in SwiftUI and TCA.
   > Added some UX improvements.

- TCA for state management of our feature
- SwiftUI for the views
- Dependency injection and will follow PF Dependency lib

4. Add App Icon
   > I'm not a designer 🙃 but it was worth a shot

- Cause let's give the little guy some love

---

I'm about two hours in now.

When I ran this I thougth the results came as multiple words, but now I realize it's just a word and the definitions. Rather than tabs below, I may have a button to fetch similar words from the Thesaurus.

Rather than swiping to favorite, I can have a simple button. In order to make this a little more "safe" each word may need an `id` but I could also use the word itself as a key.

5. Tab View

- Tabs for Dictionary/Thesaurus

6. Swipe action to "Favorite" a word

- I think we can get here
- If time allows, add some kind of caching or save locally? SwiftData?
