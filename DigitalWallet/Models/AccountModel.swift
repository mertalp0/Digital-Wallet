//
//  Account.swift
//  DigitalWallet
//
//  Created by mert alp on 19.07.2024.
//

import Foundation

struct Account {
  
    var iban: String
    var balance: String
    var earned: String
    var spent: String
    var transfers: [String]
    
    init( iban: String, balance: String, earned: String, spent: String, transfers: [String]) {
        self.iban = iban
        self.balance = balance
        self.earned = earned
        self.spent = spent
        self.transfers = transfers
    }
}
