//
//  HomeViewModel.swift
//  wallet
//
//  Created by Edvaldo Martins on 13/11/2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var cards: [Card] = []
    @Published var currentCard: Card?
    @Published var expanded:Bool = false
    @Published var showDetailCard: Bool = false
 
    init() {
        fetchCards()
    }
    
    func fetchCards() {
        self.cards = DataLoader.loadModels(fromFileNamed: "cards.json")
    }
    
    func setShowDetailCard (_ value: Bool) {
        showDetailCard = value
    }
    
    func setCurrentCard (_ value: Card?) {
        currentCard = value
    }
    
    func getIndex(card: Card) -> Int {
        return cards.firstIndex { item in
            return item.id == card.id
        } ?? 0
    }
}

 
