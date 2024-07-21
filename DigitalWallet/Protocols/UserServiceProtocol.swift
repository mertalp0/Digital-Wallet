//
//  UserServiceProtocol.swift
//  DigitalWallet
//
//  Created by mert alp on 19.07.2024.
//

import Foundation
import FirebaseFirestore

protocol UserServiceProtocol {
      var db: Firestore { get }
      var authService: AuthenticationServiceProtocol { get }
    static  var shared: UserService { get }
    func fetchUser(completion: @escaping (UserModel?, Error?) -> Void)
}
