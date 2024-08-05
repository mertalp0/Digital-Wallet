//
//  TransactionModel.swift
//  DigitalWallet
//
//  Created by mert alp on 31.07.2024.
//

import Foundation

struct Transaction: Identifiable, Codable {
    let id: String
    let category: String
    let iconName: String
    let amount: Double
    let createdAt: Date
}
