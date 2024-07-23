//
//  AuthenticationService.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import CryptoKit

class AuthenticationService: AuthenticationServiceProtocol {
    static let shared = AuthenticationService()
    private let db = Firestore.firestore()
    private let accountService: AccountServiceProtocol = AccountService()
    private let encryptionService: EncryptionService
    
    init() {
        let key = SymmetricKey(size: .bits256)
        self.encryptionService = EncryptionService(key: key)
    }
    
    func getCurrentUser() -> User? {
        return Auth.auth().currentUser
    }
    
    func login(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(AuthenticationServiceError(type: .firebaseError(error))))
                return
            }
            
            guard let user = authResult?.user else {
                completion(.failure(AuthenticationServiceError(type: .userNotFound)))
                return
            }
            
            if user.isEmailVerified {
                let userRef = self.db.collection("users").document(user.uid)
                userRef.getDocument { document, error in
                    if let error = error {
                        completion(.failure(AuthenticationServiceError(type: .firebaseError(error))))
                        return
                    }
                    
                    guard let document = document, document.exists, let data = document.data() else {
                        completion(.failure(AuthenticationServiceError(type: .firebaseDocumentNotFound)))
                        return
                    }
                    
                    guard let id = data["id"] as? String,
                          let fullName = data["fullname"] as? String,
                          let email = data["email"] as? String,
                          let accountId = data["accountIban"] as? String,
                          let cards = data["cards"] as? [String] else {
                        completion(.failure(AuthenticationServiceError(type: .firebaseDataCorrupted)))
                        return
                    }
                    
                    let currentUser = UserModel(id: id, fullName: fullName, email: email, accountId: accountId, cards: cards)
                    completion(.success(currentUser))
                }
            } else {
                completion(.failure(AuthenticationServiceError(type: .emailNotVerified)))
            }
        }
    }
    
    func register(fullname: String, email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(AuthenticationServiceError(type: .firebaseError(error))))
                return
            }
            
            guard let user = authResult?.user else {
                completion(.failure(AuthenticationServiceError(type: .userNotCreated)))
                return
            }
            
            self.accountService.addAccount { account, error in
                if let error = error {
                    print(error)
                    completion(.failure(AuthenticationServiceError(type: .accountCreationFailed)))
                    return
                }
                
                guard let account = account else {
                    completion(.failure(AuthenticationServiceError(type: .accountCreationFailed)))
                    return
                }
                
                guard let encryptedPassword = self.encryptionService.encrypt(plainText: password) else {
                    completion(.failure(AuthenticationServiceError(type: .encryptionFailed)))
                    return
                }
                
                let userData: [String: Any] = ["id": user.uid, "fullname": fullname, "email": email, "password": encryptedPassword, "accountIban": account.iban, "cards": []]
                self.db.collection("users").document(user.uid).setData(userData) { error in
                    if let error = error {
                        completion(.failure(AuthenticationServiceError(type: .firebaseError(error))))
                        return
                    }
                    
                    user.sendEmailVerification { error in
                        if let error = error {
                            completion(.failure(AuthenticationServiceError(type: .firebaseError(error))))
                            return
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
        } catch let error {
            completion(.failure(AuthenticationServiceError(type: .firebaseError(error))))
        }
    }
    
    func passwordReset(email: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(AuthenticationServiceError(type: .firebaseError(error))))
                return
            }
            completion(.success(true))
        }
    }
}
