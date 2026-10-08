//
//  Project: ScoreKeeperDemo
//  File: ContentView.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI

/// The main screen, and the **owner** of the game.
///
/// Every wrapper in this project answers one question: *who owns this data, and who needs to change it?*
///
/// | Situation | Wrapper |
/// |---|---|
/// | This view owns a simple value | `@State` |
/// | A child changes its parent's value | `@Binding` (see ScoreButtons) |
/// | Several views share a model | an `@Observable` class, owned with `@State` (see Game) |
/// | A view was handed that model and edits it | `@Bindable` (see EditNamesView) |
/// | A view far below needs it | `@Environment` (see ResetButton) |
struct ContentView: View {
    // Still @State, even for a whole model: the owner creates it, whether it's a number or a class.
    @State private var game = Game()
    // Whether the sheet is up is this view's business, so it's this view's state.
    @State private var isEditingNames = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
                // The dollar sign on `$game.players` makes each pass hand us `$player`: a binding to
                // one player in the array. Without it you get copies, and ScoreButtons won't compile,
                // because a copy has no binding to give.
                ForEach($game.players) { $player in
                    VStack {
                        // Reading only, so no dollar sign.
                        Text(player.name)
                            .font(.title2)
                        Text("\(player.score)")
                            .font(.system(size: 72, weight: .bold))
                            .monospacedDigit()   // digits keep the same width, so the number doesn't jiggle
                        ScoreButtons(score: $player.score)
                    }
                }
            }
            .navigationTitle("Score Keeper")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    // No arguments: ResetButton reaches for the game through the environment.
                    ResetButton()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Edit Names") {
                        isEditingNames = true
                    }
                }
            }
            .sheet(isPresented: $isEditingNames) {
                // `game` with no dollar sign: a class is shared, not copied, so the sheet edits
                // the very same game, and the names above change as you type.
                EditNamesView(game: game)
                    .presentationDetents([.medium])   // stops halfway so the scores stay visible
            }
        }
        // Puts the game into the environment for every view inside the NavigationStack.
        // Views below can reach it; views above can't. Leave this out and everything still builds,
        // then the first tap on Reset crashes.
        .environment(game)
    }
}

#Preview {
    ContentView()
}
