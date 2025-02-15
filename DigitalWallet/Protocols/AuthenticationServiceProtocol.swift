//
//  AuhtenticationServiceProtocol.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import Foundation
import FirebaseAuth


protocol AuthenticationServiceProtocol {
    func getCurrentUser() -> User?
    
    func login(email: String,
               password: String,
               completion : @escaping(Result<UserModel,Error>)-> Void)

    func register(fullname: String,
                  email:String,
                  password:String,
                  completion : @escaping(Result<Bool,Error>)->Void)
    
    func logout(completion:@escaping(Result<Bool,Error>)->Void)
    
    func passwordReset(email:String,
                       completion: @escaping(Result<Bool,Error>)->Void
    )

}
