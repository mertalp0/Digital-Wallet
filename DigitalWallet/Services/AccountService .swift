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
    
    // Hesap verilerini almak için kullanılan işlev
    func fetchAccount(accountId: String, completion: @escaping (Account?, Error?) -> Void) {
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
                                 let earned = data["earned"] as? String,
                                 let spent = data["spent"] as? String,
                                 let transfers = data["transfers"] as? [String] {
                                  
                                  let accountInfo = Account(id: id, iban: iban, balance: balance, earned: earned, spent: spent, transfers: transfers)
                                  completion(accountInfo, nil)
                } else {
                    completion(nil, NSError(domain: "BankService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Account data is corrupted"]))
                }
            } else {
                completion(nil, NSError(domain: "BankService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Account document does not exist"]))
            }
        }
    }
    
    // Hesap verilerini Firestore'a ekleyen işlev
    func addAccount(completion: @escaping (Account?, Error?) -> Void) {
        let newDocumentRef = db.collection("account").document() // Yeni bir belge referansı oluşturur ve otomatik bir ID atar
        
        // IBAN oluşturma
        let generatedIBAN = generateRandomIBAN()
        
        // Hesap verilerini temsil eden bir sözlük oluşturun
        let accountData: [String: Any] = [
            "balance": "0.0",         // Başlangıçta sıfır
            "earned": "0",            // Başlangıçta sıfır
            "iban": generatedIBAN,    // Rastgele oluşturulan 16 haneli IBAN
            "id": newDocumentRef.documentID, // Otomatik olarak oluşturulan belge ID'si
            "spent": "0",             // Başlangıçta sıfır
            "transfers": []           // Başlangıçta boş bir dizi
        ]
        
        // Hesap verilerini Firestore'a ekleyin
        newDocumentRef.setData(accountData) { error in
            if let error = error {
                completion(nil, error)
            } else {
                // Başarıyla veri eklendiğinde, Account nesnesini oluştur
                let account = Account(
                    id: newDocumentRef.documentID,
                    iban: generatedIBAN,
                    balance: "0.0",
                    earned: "0",
                    spent: "0",
                    transfers: []
                )
                completion(account, nil)
            }
        }
    }}
