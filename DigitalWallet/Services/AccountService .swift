//
//  BankInfoService .swift
//  DigitalWallet
//
//  Created by mert alp on 19.07.2024.
//
import Foundation
import FirebaseFirestore


class AccountService: AccountServiceProtocol {
    private let db = Firestore.firestore()

    func fetchAccount(accountId: String, completion: @escaping (Account?, Error?) -> Void) {
        db.collection("account").document(accountId).getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let snapshot = snapshot, snapshot.exists {
                if let data = snapshot.data(),
                   let balance = data["balance"] as? String,
                   let iban = data["iban"] as? String,
                   let earned = data["earned"] as? String,
                   let spent = data["spent"] as? String,
                   let transfers = data["transfers"] as? [String] {
                    
                    let accountInfo = Account(iban: iban, balance: balance, earned: earned, spent: spent, transfers: transfers)
                    completion(accountInfo, nil)
                } else {
                    completion(nil,AccountServiceError.dataCorrupted)
                    
                }
            } else {
                completion(nil,AccountServiceError.documentNotFound)
            }
        }
    }

    func addAccount(completion: @escaping (Account?, Error?) -> Void) {
        
        let generatedIBAN = generateRandomIBAN()
        let newDocumentRef = db.collection("account").document(generatedIBAN)
        
        let accountData: [String: Any] = [
            "balance": "0.0",
            "earned": "0.0",
            "iban": generatedIBAN,
            "spent": "0.0",
            "transfers": []
        ]
    
        newDocumentRef.setData(accountData) { error in
            if let error = error {
                completion(nil, error)
            } else {
                
                let account = Account(
                    iban: generatedIBAN,
                    balance: "0.0",
                    earned: "0.0",
                    spent: "0.0",
                    transfers: []
                )
                completion(account, nil)
            }
        }
    }
    
    
    
}
