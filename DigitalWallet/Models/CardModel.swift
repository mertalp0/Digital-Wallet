//
//  CardModel.swift
//  DigitalWallet
//
//  Created by mert alp on 11.07.2024.
//

import Foundation

struct CardModel: Identifiable, Codable {
    let id: String
    let cardHolder: String
    let cardNumber: String
    let expiryDate: Date
    let balance: Double
    var transactions: [Transaction]
}
