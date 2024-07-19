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
    
    func fetchAccount(accountId: String , completion: @escaping (Account?, Error?) -> Void) {
        db.collection("account").document(accountId).getDocument { snapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let snapshot = snapshot, snapshot.exists {
                if let data = snapshot.data(),
                   let id = data["id"] as? String,
                   let balance = data["balance"] as? String,
                   let iban = data["iban"] as? String,
                   let transfers = data["transfers"] as? [String] {
                    
                    let accountInfo = Account(id: id, iban: iban, balance: balance, transfers: transfers)
                    completion(accountInfo, nil)
                } else {
                    completion(nil, NSError(domain: "BankService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Account data is corrupted"]))
                }
            } else {
                completion(nil, NSError(domain: "BankService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Account document does not exist"]))
            }
        }
    }
}
