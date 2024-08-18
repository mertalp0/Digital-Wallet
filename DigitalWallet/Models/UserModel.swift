//
//  UserModel.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import Foundation

struct UserModel : Codable  {
    var id: String
    var fullName: String
    var email: String
    var accountIban: String
    var cards: [String]
    var password: String?
    
    init(id: String, fullName: String, email: String, accountIban: String, cards: [String] , password : String?) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.accountIban = accountIban
        self.cards = cards
        self.password = password
    }
    

}
