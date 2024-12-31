### Steps to Run the App

* No unusual steps other than ensuring the RecipeApp target is selected, building, and running.

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

* Caching - I built a LRU cache that also persists images to disk.

* Generics - I emphasized generics to make components reusable and more easily testable. I was able to easily create mock objects and stub objects to use in the SwiftUI Previews as well as unit tests.

* Networking - All network requests including API endpoint requests and image requests, are queued and cancellable.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

* I honestly have no idea. I enjoyed the exercise and didn't keep track.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

* No significant trade-offs come to mind.

### Weakest Part of the Project: What do you think is the weakest part of your project?

* The UI is kind of simplistic but I wanted to focus on a good foundation and architecture that could be tested and scaled properly.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

* It's a one-screen app. Add any more screens and I'd incorporate the Coordinator pattern.

* I used the new @Observable macro available in iOS 17 which meant I didn't need to use @Published to observe data changes.

- Assumptions: Swift 5.9+, iOS 17 (Use of @Observable macro)
