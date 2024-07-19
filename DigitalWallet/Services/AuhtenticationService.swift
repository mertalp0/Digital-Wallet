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
    
    
    func login(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                completion(.failure(error))
                return
            }

            guard let user = authResult?.user else {
                //TODO: SERVICE WILL BE REGISTERED FOR ERRORS
                completion(.failure(NSError(domain: "AuthenticationService", code: 0, userInfo: [NSLocalizedDescriptionKey: "User not found."])))
                return
            }

            if user.isEmailVerified {
                // TODO: Fetch data from Firebase with user.uid
                let currentUser = UserModel(id: "", fullName: "", email: "", accountId: "", cards: [""])
                completion(.success(currentUser))
                
            } else {
                //TODO: SERVICE WILL BE REGISTERED FOR ERRORS
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
            
            let userData: [String: Any] = ["fullname": fullname, "email": email ,"password": password]
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
