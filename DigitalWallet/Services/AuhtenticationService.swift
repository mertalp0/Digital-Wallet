//
//  AuthenticationService.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationService: AuthenticationServiceProtocol {
    static let shared = AuthenticationService()
    private let db = Firestore.firestore()
    private let accountService :AccountServiceProtocol = AccountService()
    
    func getCurrentUser() -> User? {
         return Auth.auth().currentUser
     }
    
    func login(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                completion(.failure(error))
                return
            }

            guard let user = authResult?.user else {
                completion(.failure(NSError(domain: "AuthenticationService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found."])))
                return
            }

            if user.isEmailVerified {
                // Firestore'dan kullanıcı verilerini çek
                let userRef = self.db.collection("users").document(user.uid)
                userRef.getDocument { document, error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    guard let document = document, document.exists, let data = document.data() else {
                        completion(.failure(NSError(domain: "AuthenticationService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User data not found."])))
                        return
                    }

                    guard let id = data["id"] as? String,
                          let fullName = data["fullName"] as? String,
                          let email = data["email"] as? String,
                          let accountId = data["accountId"] as? String,
                          let cards = data["cards"] as? [String] else {
                        completion(.failure(NSError(domain: "AuthenticationService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User data is corrupted."])))
                        return
                    }

                    let currentUser = UserModel(id: id, fullName: fullName, email: email, accountId: accountId, cards: cards)
                    completion(.success(currentUser))
                }
            } else {
                completion(.failure(NSError(domain: "AuthenticationService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Email not verified."])))
            }
        }
    }
    func register(fullname: String, email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = authResult?.user else {
                completion(.failure(NSError(domain: "AuthenticationService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not created."])))
                return
            }
            self.accountService.addAccount { account, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                if let account = account {
                    let userData: [String: Any] = ["id": user.uid, "fullname": fullname, "email": email ,"password": password ,"accountId": account.id , "cards":[]]
                    self.db.collection("users").document(user.uid).setData(userData) { error in
                        if let error = error {
                            completion(.failure(error))
                            return
                        }
                        user.sendEmailVerification { error in
                            if let error = error {
                                completion(.failure(error))
                                return
                            }
                        }
                        completion(.success(true))
                    
                }
                
                
            }
     
            }
        }
    }
    
    func logout(completion: @escaping (Result<Bool, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(true))
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    func passwordReset(email: String,  completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(true))
        }
    }
    
}
