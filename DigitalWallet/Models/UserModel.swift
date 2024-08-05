//
//  UserModel.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import Foundation

struct UserModel {
    var id: String
    var fullName: String
    var email: String
    var accountId : String
    var cards : [String]
    
    init(id: String, fullName: String, email: String , accountId : String , cards:[String]) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.accountId = accountId
        self.cards = cards
    }
}
