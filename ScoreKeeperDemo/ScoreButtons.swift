//
//  Project: ScoreKeeperDemo
//  File: ScoreButtons.swift
//  Created by Noah Carpenter
//
//  📺 YouTube: Noah Does Coding
//  https://www.youtube.com/@NoahDoesCoding
//  Like and Subscribe for coding tutorials and fun! 💻✨
//  Dream Big. Code Bigger 🚀
//

import SwiftUI

/// A Minus and a Plus button that change a score this view does **not** own.
///
/// The common first attempt is `@State var score = 0` here. It compiles and the buttons work,
/// but they change this view's own copy: there are now two scores, and the screen shows the one
/// nobody is changing. A child that changes its parent's value takes a binding instead.
struct ScoreButtons: View {
    // A binding is a connection to a value someone else owns. Reading it gives the parent's score,
    // writing it changes the parent's score. No starting value: the score was never this view's.
    @Binding var score: Int

    var body: some View {
        HStack(spacing: 32) {
            Button("Minus", systemImage: "minus.circle.fill") {
                score -= 1
            }
            Button("Plus", systemImage: "plus.circle.fill") {
                score += 1
            }
        }
        .labelStyle(.iconOnly)
        .font(.largeTitle)
    }
}

#Preview {
    // The preview has no parent to borrow a score from. `.constant(3)` is a binding that always
    // reads 3 and ignores writes: fine for a preview, never for the app.
    ScoreButtons(score: .constant(3))
}
