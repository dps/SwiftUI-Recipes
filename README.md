# SwiftUI-Recipes

A demo app showing how to fetch data from the server to populate list views, navigate to detailed results and wire in a search field.

### About
This project is a SwiftUI implementation of my goto recipe app example for playing around in new languages / environments.

| | Features |
| -- | -- |
| ⚡️ | Using `BindableObject` + `URLSession` to request and decode JSON payloads into `Identifiable` models. |
| ☔️| Gracefully handling `loading` and and `error` states using a generic `LoadableState` enum. |
| 🤞| Conditionally displaying `View` elements based on state. |
| 🖼| Fetching and displaying images from a `URL`. |
| 🔄 | Adding `UIActivityIndicator` as an unofficial `View` element. |

![app-ui](https://user-images.githubusercontent.com/22358682/59354464-2d82d000-8cf3-11e9-8d62-d542779c49db.png)

### Usage
1. Clone or download this project
2. Navigate to its directory and open the project file in Xcode 11 or above
3. Build and run to a device or simulator

<p align="center">
Made by <a href="https://twitter.com/dps">dps</a> with inspiration from Apple's samples and Mat Schmid's SwiftUI-ListFetching demo.
</p>
