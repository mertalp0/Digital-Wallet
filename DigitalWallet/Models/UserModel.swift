//
//  UserModel.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import Foundation

class UserModel {
    var id: String
    var fullName: String
    var email: String
    var password: String
    
    init(id: String, fullName: String, email: String, password: String) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.password = password
    }
}
