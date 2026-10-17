# 🎯 StateManagementDemo_SwiftUI

A tiny SwiftUI project that picks between `@State`, `@Binding`, `@Observable`, `@Bindable` and `@Environment` by asking one question: **who owns this data, and who needs to change it?**

---

## 🤔 What this is

Five property wrappers, one decision made five times. The project is a two-player score keeper where each wrapper shows up exactly where the answer to that question changes:

| Who owns it, who changes it | The wrapper | Where |
|---|---|---|
| This view owns a simple value | `@State` | `ContentView` (`isEditingNames`) |
| A child changes its parent's value | `@Binding` | `ScoreButtons` |
| Several views share a model | an `@Observable` class, owned with `@State` | `Game`, owned by `ContentView` |
| A view was handed that model and edits it | `@Bindable` | `EditNamesView` |
| A view far below needs it | `@Environment` | `ResetButton` |

The finished app: two players with Plus and Minus buttons, a half sheet that renames players live, and a Reset button that reaches the game without being handed anything.

## ✅ Why you'd use it

- **One rule instead of five definitions.** Ask who owns the data, and the wrapper picks itself.
- **The bug everyone hits, explained.** `ScoreButtons` with its own `@State` compiles and does nothing visible. The comments show why, and the one-word fix.
- **The modern Observation APIs.** `@Observable`, `@Bindable` and `@Environment(Type.self)`, with notes on what `ObservableObject`, `@StateObject`, `@ObservedObject` and `@EnvironmentObject` became.
- **Heavily commented.** Every wrapper explains why it's that wrapper and what breaks without it.

## 📺 Watch on YouTube

[![Watch on YouTube](https://img.shields.io/badge/YouTube-Watch%20the%20Tutorial-red?style=for-the-badge&logo=youtube)](https://youtu.be/4rB4GlhKA5k)

> This project was built for the [NoahDoesCoding YouTube channel](https://www.youtube.com/@NoahDoesCoding).

---

## 🚀 Getting Started

### 1. Clone

```bash
git clone https://github.com/NDCSwift/StateManagementDemo_SwiftUI.git
cd StateManagementDemo_SwiftUI
```

### 2. Open

```bash
open ScoreKeeperDemo.xcodeproj
```

### 3. Run on an iPhone simulator

Pick an **iPhone** simulator as the run destination and press **⌘R**. No Apple Developer account is needed for the Simulator.

### 4. Team (device only)

Select the project in the navigator → **Signing & Capabilities** → set your own **Team**. Not required for the Simulator.

### 5. Bundle ID (device only)

The default bundle identifier is `com.example.ScoreKeeperDemo`. Change it to something unique (e.g. `com.yourname.ScoreKeeperDemo`) if you plan to run on a device.

## 🛠️ Notes

Three experiments worth trying, each a one-line change:

- **Own it twice.** In `ScoreButtons`, change `@Binding var score: Int` to `@State var score = 0` and pass nothing from `ContentView`. Plus still works, but the big number never moves: there are two scores now.
- **Drop `@Bindable`.** In `EditNamesView`, make it a plain `var game: Game`. Xcode stops you: *Cannot find '$game' in scope*. Reading is fine; bindings need `@Bindable`.
- **Forget the provider.** Delete `.environment(game)` in `ContentView`. Everything builds, and the first tap on Reset crashes, because no `Game` was put in the environment.

Also:

- Open **Edit Names** and type: the name on the main screen changes letter by letter, because the sheet and the screen share one game.
- **Not every value needs a model.** A toggle one view uses is `@State`; wrapping it in a class buys you nothing.

## 📦 Requirements

- Xcode 27 (the project file uses Xcode 27's format; the Swift files themselves work with Xcode 15 or later)
- iOS 17.0+ deployment target (`@Observable`, `@Bindable` and `@Environment(Type.self)` need iOS 17)
- Swift / SwiftUI
