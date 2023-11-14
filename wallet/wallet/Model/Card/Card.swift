//
//  File.swift
//  wallet
//
//  Created by Edvaldo Martins on 08/11/2023.
//

import Foundation
import SwiftUI

struct Card: Codable, Identifiable, Equatable {
    let id = UUID()
    let balance: Double
    let cardNumber: String
    let cardHolderName: String
    let logoName: String
    let colorName: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        balance = try values.decode(Double.self, forKey: .balance)
        cardNumber = try values.decode(String.self, forKey: .cardNumber)
        cardHolderName = try values.decode(String.self, forKey: .cardHolderName)
        logoName = try values.decode(String.self, forKey: .logo)
        colorName = try values.decode(String.self, forKey: .color)
    }
    
    private enum Keys: String, CodingKey {
        case balance, cardNumber, cardHolderName, logo, color
    }
    
    static func getMock () -> Card {
        return DataLoader.loadModels(fromFileNamed: "cards.json")[0]
    }
    
    var getColor: Color {
        Color(colorName)
    }
    
    var getLogo: Image {
        Image(logoName)
    }
    
    var maskNumberCard: String {
        var newValue: String = ""
        let maxCount = cardNumber.count - 4
        
        cardNumber.enumerated().forEach { value in
            if value.offset >= maxCount {
                let string = String(value.element)
                newValue.append(contentsOf: string)
            }else{
                let string = String(value.element)
                if string == " " {
                    newValue.append(contentsOf: " ")
                }else{
                    newValue.append(contentsOf: "*")
                }
            }
        }
        
        return newValue
    } 
}

extension Card {
    
    var formatterBalance: String {
        let currencyFormatter: NumberFormatter = {
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.currencySymbol = "$"
            currencyFormatter.locale = Locale(identifier: "en")
            return currencyFormatter
        }()
        return currencyFormatter.string(from: NSNumber(value: balance)) ?? ""
    }
}


