//
//  MemorizeApp.swift
//  Memorize
//
//  Created by 中原資管 on 2023/3/20.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
