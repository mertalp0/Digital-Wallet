//
//  UserService.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import FirebaseAuth
import FirebaseFirestore

class UserService: UserServiceProtocol {
    
    internal let db = Firestore.firestore()
    internal let authService: AuthenticationServiceProtocol
    static let shared = UserService()
    @Published var user: UserModel?

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
                if let data = snapshot.data() {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                        let user = try JSONDecoder().decode(UserModel.self, from: jsonData)
                        UserService.shared.user = user
                        completion(user, nil)
                    } catch {
                        completion(nil, UserServiceError(type: .userDataCorrupted))
                    }
                } else {
                    completion(nil, UserServiceError(type: .userDataCorrupted))
                }
            } else {
                completion(nil, UserServiceError(type: .userDocumentNotFound))
            }
        }
    }
}
