//
//  TransferModel.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//

import Foundation

enum PaymentType: String, Codable {
    case iban = "IBAN"
    case card = "Card"
    case cash = "Cash"
}

struct Transfer: Identifiable, Codable {
    var id: String = UUID().uuidString
    var iban: String
    var amount: Double
    var date: Date = Date()
    var description: String
    var paymentType: PaymentType

    init(iban: String, amount: Double, description: String, paymentType: PaymentType) {
        self.iban = iban
        self.amount = amount
        self.description = description
        self.paymentType = paymentType
    }
}
