//
//  UserService.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseAuth
import FirebaseFirestore


protocol UserServiceProtocol {
    func fetchUser(completion: @escaping (UserModel?, Error?) -> Void)
}


class UserService: UserServiceProtocol {
    
    static let shared = UserService()
    private let db = Firestore.firestore()
    
    func fetchUser(completion: @escaping (UserModel?, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(nil, NSError(domain: "UserService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]))
            return
        }
        
        db.collection("users").document("gUh3YyDJmfcAciNb8Skmdu6lqsE3").getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let snapshot = snapshot, snapshot.exists {
                if let data = snapshot.data(),
                   let fullName = data["fullName"] as? String,
                   let email = data["email"] as? String,
                   let accountId = data["accountId"] as? String,
                   let cards = data["cards"] as? [String] {
                    
                    let user = UserModel(id: userId, fullName: fullName, email: email, accountId: accountId, cards: cards)
                    completion(user, nil)
                } else {
                    completion(nil, NSError(domain: "UserService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User data is corrupted"]))
                }
            } else {
                completion(nil, NSError(domain: "UserService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User document does not exist"]))
            }
        }
    }
}
