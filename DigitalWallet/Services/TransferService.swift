//
//  TransferService.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//
import Foundation
import FirebaseFirestore
import FirebaseAuth

class TransferService: TransferServiceProtocol {
    private let db = Firestore.firestore()
    private let authService: AuthenticationServiceProtocol
    
    init(authService: AuthenticationServiceProtocol = AuthenticationService()) {
        self.authService = authService
    }
    
    func sendMoney(iban: String, amount: Double, date: Date, type: String, description: String, completion: @escaping (Bool?, Error?) -> Void) {
        guard let userId = authService.getCurrentUser()?.uid else {
            completion(false, UserServiceError(type: .userNotAuthenticated))
            return
        }
        
        let transferData: [String: Any] = [
            "iban": iban,
            "senderId": userId,
            "amount": amount,
            "date": Timestamp(date: date),
            "type": type,
            "description": description
        ]
        
        db.collection("transfers").addDocument(data: transferData) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
