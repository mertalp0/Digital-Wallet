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
    var balance : String
    var transfers: [String]
    
    init(id: String, iban: String, balance: String, transfers: [String]) {
        self.id = id
        self.iban = iban
        self.balance = balance
        self.transfers = transfers
    }
}
