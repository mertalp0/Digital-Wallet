//
//  MockData.swift
//  DigitalWallet
//
//  Created by mert alp on 31.07.2024.
//

import Foundation

struct MockData {
    static let sampleCards: [CardModel] = [
        CardModel(
            id: "0", cardHolder: "Mert Alp",
            cardNumber: "2423358195032412",
            expiryDate: Date(),
            balance: 3100.30,
            transactions: [
                Transaction(id: "1", category: "yılmaz market", iconName: "cart.fill", amount: 100, createdAt: Date())
                ]
        ),
        CardModel(
            id: "1", cardHolder: "Leslie Alexander",
            cardNumber: "2423 3581 9503 2412",
            expiryDate: Date(),
            balance: 3100.30,
            transactions: [
               ]
        ),
        CardModel(
            id: "2", cardHolder: "John Doe",
            cardNumber: "1234 5678 9012 3456",
            expiryDate:  Date(),
            balance: 2500.00,
            transactions: [
             ]
        )
    ]
}
