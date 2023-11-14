//
//  CardsViewModel.swift
//  wallet
//
//  Created by Edvaldo Martins on 08/11/2023.
//

import SwiftUI
import Combine
import Foundation

class TransactionsViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        self.transactions = DataLoader.loadModels(fromFileNamed: "payments.json")
        transactions.shuffle()
    }
}

 
