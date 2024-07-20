//
//  UserService.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//
import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserService: UserServiceProtocol {
    
    internal let db = Firestore.firestore()
    internal let authService: AuthenticationServiceProtocol
    static let shared = UserService()
    
    init(authService: AuthenticationServiceProtocol = AuthenticationService.shared) {
        self.authService = authService
    }
    
    func fetchUser(completion: @escaping (UserModel?, Error?) -> Void) {
        guard let userId = authService.getCurrentUser()?.uid else {
            completion(nil, UserServiceError(type: .userNotAuthenticated))
            return
        }
        
        db.collection("users").document(userId).getDocument { snapshot, error in
            if let error = error {
                completion(nil, UserServiceError(type: .firebaseError(error)))
                return
            }
            if let snapshot = snapshot, snapshot.exists {
                if let data = snapshot.data(),
                   let fullName = data["fullname"] as? String,
                   let email = data["email"] as? String,
                   let accountId = data["accountId"] as? String,
                   let cards = data["cards"] as? [String] {
                    
                    let user = UserModel(id: userId, fullName: fullName, email: email, accountId: accountId, cards: cards)
                    completion(user, nil)
                } else {
                    completion(nil, UserServiceError(type: .userDataCorrupted))
                }
            } else {
                completion(nil, UserServiceError(type: .userDocumentNotFound))
            }
        }
    }
}
