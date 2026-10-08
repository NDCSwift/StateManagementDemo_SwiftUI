//
//  Project: ScoreKeeperDemo
//  File: EditNamesView.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI

/// The rename sheet. It doesn't own the game, ContentView does. It's handed the game and edits it.
struct EditNamesView: View {
    // To *read* an @Observable model, or call its methods, a plain `var game: Game` is enough:
    // SwiftUI still watches what you read. To make *bindings* into it (the `$game` below, a text
    // field writing straight into a player's name) you need @Bindable.
    // Remove it and Xcode says: "Cannot find '$game' in scope".
    @Bindable var game: Game

    var body: some View {
        Form {
            // `$game.players` hands each pass a binding to one player in the game, not a copy,
            // so each TextField writes into the real name.
            ForEach($game.players) { $player in
                TextField("Name", text: $player.name)
            }
        }
    }
}

#Preview {
    // The preview gets a fresh Game of its own; it only needs something to show.
    EditNamesView(game: Game())
}
