//
//  Payment.swift
//  wallet
//
//  Created by Edvaldo Martins on 10/11/2023.
//

import Foundation
import SwiftUI

enum TransactionStatus: String, Codable {
    case pending
    case accepted
    case rejected
}

struct Transaction: Codable, Identifiable {
    let id = UUID()
    let amount: Double
    let service: String
    let description: String
    let reference: String
    let status: TransactionStatus
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        amount = try values.decode(Double.self, forKey: .amount)
        service = try values.decode(String.self, forKey: .service)
        description = try values.decode(String.self, forKey: .description)
        reference = try values.decode(String.self, forKey: .reference)
        status = try values.decode(TransactionStatus.self, forKey: .status)
    }
    
    private enum Keys: String, CodingKey {
        case amount,service,description, reference, status
    }
    
    static func getMock () -> Transaction {
        return DataLoader.loadModels(fromFileNamed: "payments.json")[0]
    }
    
    var formattedDate: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
   
}

extension Transaction {
    
    var isAcceped: Bool {
        return status == .accepted
    }
    
    var formatterAmount: String {
        let currencyFormatter: NumberFormatter = {
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.currencySymbol = "$"
            currencyFormatter.locale = Locale(identifier: "en")
            return currencyFormatter
        }()
        return currencyFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
}
