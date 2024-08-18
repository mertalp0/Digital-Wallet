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
                    
                    // JSONDecoder ile veri çekme
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                        let userModel = try JSONDecoder().decode(UserModel.self, from: jsonData)
                        completion(.success(userModel))
                    } catch {
                        completion(.failure(AuthenticationServiceError(type: .firebaseDataCorrupted)))
                    }
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
                
                // Kullanıcı verilerini modelle oluşturun
                let userModel = UserModel(id: user.uid, fullName: fullname, email: email, accountIban: account.iban, cards: [], password: encryptedPassword)
                
                let userData: [String: Any] = [
                    "id": userModel.id,
                    "fullName": userModel.fullName,
                    "email": userModel.email,
                    "accountIban": userModel.accountIban,
                    "cards": userModel.cards,
                    "password" : userModel.password!
                ]
                
                self.db.collection("users").document(userModel.id).setData(userData) { error in
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
