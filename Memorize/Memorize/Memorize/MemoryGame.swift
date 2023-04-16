//
//  MemoryGame.swift
//  Memorize
//
//  Created by 中原資管 on 2023/3/20.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    private var lastFaceUpIndex: Int? {
        
        get { cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly }
        set { cards.indices.forEach( { cards[$0].isFaceUp = $0 == newValue }) }
    }
    
    mutating func choose(card: Card) {
//        if let cardIndex = index(of:card){
        if let cardIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[cardIndex].isFaceUp,
           !cards[cardIndex].isMatched {
            if let lastIndex = lastFaceUpIndex{
                if cards[lastIndex].content == card.content{
                    cards[lastIndex].isMatched = true
                    cards[cardIndex].isMatched = true
                    score+=2
                }else{
                    print("cardIndex isFaceYet is \(cards[cardIndex].isTurnYet)")
                    print("lastIndex isFaceYet is \(cards[lastIndex].isTurnYet)")
                    if cards[lastIndex].isTurnYet{
                        score -= 1
                    }else{
                        cards[lastIndex].isTurnYet = true
                    }
                    if cards[cardIndex].isTurnYet{
                        score -= 1
                    }else{
                        cards[cardIndex].isTurnYet = true
                    }
                }
                cards[cardIndex].isFaceUp = true
            }
            else {
                lastFaceUpIndex = cardIndex
            }
        }
        
    }
    
    func index(of card: Card) -> Int? {
        for index in 0..<cards.count {
            if cards[index].id == card.id {
                return index
            }
        }
        
        return nil
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        for index in 0..<numberOfPairs {
            let content: CardContent = createCardContent(index)
            cards.append(Card(content: content, id: 2 * index))
            cards.append(Card(content: content, id: 2 * index + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable{
        var isFaceUp = false
        var isMatched = false
        //TODO: 是否被翻過的變數
        var isTurnYet = false
        let content: CardContent
        let id: Int
    }
}


extension Array {
    var oneAndOnly: Element? { count == 1 ? first : nil }
}
