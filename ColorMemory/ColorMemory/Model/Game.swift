//
//  Game.swift
//  ColorMemory
//
//  Created by Alex Cheung on 25/11/2019.
//  Copyright © 2019 Alex Cheung. All rights reserved.
//

import Foundation

class Game {
    var cards: [Card] = [Card]()
    var cardsShown:[Card] = [Card]()
    var cardsSelected:[Card] = [Card]()
    var isGameStarted: Bool = false
    
    func shuffleCards(cards:[Card]) -> [Card] {
        var randomCards = cards
        randomCards.shuffle()
        return randomCards
    }
    
    func newGame() -> [Card] {
        for number in 1...8 {
            for i in 1...2 {
                let card = Card(id: number, indexPosition: number * i)
                cards.append(card)
            }
        }
        cards = shuffleCards(cards: cards)
        isGameStarted = true
        return cards
    }
    
    func restartGame() {
        isGameStarted = false
        cards.removeAll()
        cardsShown.removeAll()
    }
    
    func cardAssignIndex(_ index: Int) -> Card? {
        if cards.count > index {
            return cards[index]
        } else {
            return nil
        }
    }
    
    func returnCardPosition(_ card: Card) -> Int? {
        for index in 0...cards.count-1 {
            if card === cards[index] {
                return index
            }
        }
        return nil
    }
    
    func unmatchedCardShown() -> Bool {
        return cardsShown.count % 2 != 0
    }
    
    func unmatchedCard() -> Card? {
        let unmatchedCard = cardsShown.last
        return unmatchedCard
    }
    
    func didSelectCard(_ card: Card?) -> Bool? {
        guard let card = card else { return nil }
        
        if unmatchedCardShown() {
            // Case: Select Second Card
            let unmatched = unmatchedCard()!
            
            if card.compare(unmatched) {
                // Case: Card matches
                cardsShown.append(card)
                cardsSelected.removeAll()
                return true
                
            } else {
                // Case: Card unmatch
                cardsShown.removeLast()
                cardsSelected.append(card)
                return false
            }
        } else {
            // Case: select the first card
            cardsShown.append(card)
            cardsSelected.append(card)
            return nil
        }
    }
}
