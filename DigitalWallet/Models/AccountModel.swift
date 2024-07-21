//
//  Account.swift
//  DigitalWallet
//
//  Created by mert alp on 19.07.2024.
//

import Foundation

class Account {
    var id: String
    var iban: String
    var balance: String
    var earned: String
    var spent: String
    var transfers: [String]
    
    init(id: String, iban: String, balance: String, earned: String, spent: String, transfers: [String]) {
        self.id = id
        self.iban = iban
        self.balance = balance
        self.earned = earned
        self.spent = spent
        self.transfers = transfers
    }
}
