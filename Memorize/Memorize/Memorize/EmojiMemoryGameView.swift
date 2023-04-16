//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by 中原資管 on 2023/3/20.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack {
                Text("Score: \(game.scores)")
                Spacer()
                Button(action: {
                    game.resetGame()
                }) {
                    Text("重新開始")
                }
            }
            .padding(.horizontal)
            
            Picker("Select Theme", selection: $game.currentThemeIndex) {
                ForEach(0..<EmojiMemoryGame.themePool.themes.count, id: \.self) { index in
                    Text(EmojiMemoryGame.themePool.themes[index].name).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: game.currentThemeIndex) { newThemeIndex in
                let newTheme = EmojiMemoryGame.themePool.getTheme(at: newThemeIndex)
                print("newIndex is \(newThemeIndex)")
                game.changeTheme(to: newTheme)
            }
            
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 84))]){
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
                    }
                }
            }
            
        }
        .padding(.horizontal)
        .foregroundColor(game.currentTheme.color)
    }
    
}

struct CardView: View{
    var card: EmojiMemoryGame.Card
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }else if card.isMatched{
                shape.opacity(0)
            } else  {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
