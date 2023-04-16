//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by 中原資管 on 2023/3/20.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    static let themePool = ThemePool()
    
    private static func createMemoryGame(with theme:Theme<String>) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: theme.numberOfPairs) { index in
            theme.items[index]
        }
    }
    
    @Published var currentThemeIndex = 0
    @Published var currentTheme = EmojiMemoryGame.themePool.getTheme(at: 0)
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame(with: EmojiMemoryGame.themePool.getTheme(at: 0))

    
    init(){
        currentTheme = EmojiMemoryGame.themePool.getTheme(at: 0)
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    struct Theme<ItemType: Hashable>: Hashable {
        let name: String
        let color: Color
        let numberOfPairs: Int
        let items: [ItemType]
    }

    struct ThemePool {
        var themes: [Theme<String>] = [
            Theme(name: "Ball", color: .red, numberOfPairs: 6, items: ["⚽️", "🏀", "🏈", "🎱", "🏐", "🎾",]),
            Theme(name: "Gesture", color: .blue, numberOfPairs: 8, items: ["👋", "🤚", "👌", "👍", "👎", "🤏", "✌️", "🤞"]),
            Theme(name: "Fruit", color: .green, numberOfPairs: 10, items: ["🍏", "🍎", "🍐", "🍊", "🍋", "🍓", "🍇", "🍉", "🍌", "🥭"])
        ]
        
        func getTheme(at index: Int) -> Theme<String> {
            return themes[index % themes.count]
        }
        
        mutating func addTheme(_ theme: Theme<String>) {
            themes.append(theme)
        }
    }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var scores: Int{
        return model.score
    }
    
    func changeTheme(to theme: Theme<String>) {
        print("你㪋")
        currentTheme = theme
        currentThemeIndex = EmojiMemoryGame.themePool.themes.firstIndex(of: theme) ?? 0
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    func resetGame() {
        let randomIndex = Int.random(in: 0..<EmojiMemoryGame.themePool.themes.count)
        currentTheme = EmojiMemoryGame.themePool.getTheme(at: randomIndex)
        currentThemeIndex = randomIndex
        model = EmojiMemoryGame.createMemoryGame(with: currentTheme)
    }
    
    
    //MARK: - View Operations
    
    func choose(_ card: Card) {
        //objectWillChange.send()
        model.choose(card: card)
    }
    
}
