//
//  Project: ScoreKeeperDemo
//  File: ResetButton.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI

/// A Reset button that reaches for the game itself instead of being handed it.
struct ResetButton: View {
    // Ask the environment for whatever `Game` a view above put there with `.environment(game)`.
    // No initializer argument, nothing passed in. If no view above provides a Game,
    // the first read of `game` crashes the app, so the provider is not optional.
    @Environment(Game.self) private var game

    var body: some View {
        Button("Reset") {
            game.reset()
        }
    }
}

#Preview {
    // Same rule in a preview: put a Game into the environment, or the button has nothing to reach.
    ResetButton()
        .environment(Game())
}
