//
//  Project: ScoreKeeperDemo
//  File: Game.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import Foundation
import Observation   // where the @Observable macro comes from

/// One player: a name and a score.
///
/// A struct, because a player is just a value. It lives inside `Game`, and SwiftUI edits it
/// through bindings (`$player.score`, `$player.name`) rather than by holding on to it.
struct Player: Identifiable {
    // `Identifiable` lets `ForEach` tell one player from the next without being told how.
    let id = UUID()
    var name: String
    var score = 0
}

/// The game several views share: the main screen, the rename sheet and the Reset button.
///
/// - A **class**, not a struct, so every view that touches the game touches the *same* one.
///   Hand it to a sheet without a dollar sign and the sheet gets this exact instance, not a copy.
/// - **@Observable** so SwiftUI can watch it: any view that reads a property redraws when that
///   property changes, and only those views. Without it, the class changes and the screen never hears.
@Observable
class Game {
    var players = [
        Player(name: "Player 1"),
        Player(name: "Player 2"),
    ]

    /// Sets every score back to zero.
    ///
    /// This lives on `Game` because resetting is something the game does to its own players.
    /// Any view that can reach the game can call it without knowing how the scores are stored.
    func reset() {
        // Walk the players by index: `for player in players` would hand us copies,
        // and setting a copy's score changes nothing in the array.
        for index in players.indices {
            players[index].score = 0
        }
    }
}
