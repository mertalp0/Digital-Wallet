//
//  CardsService.swift
//  DigitalWallet
//
//  Created by mert alp on 1.08.2024.
//
import Foundation
import FirebaseFirestore

class CardService: CardServiceProtocol {
    private let db = Firestore.firestore()
    

    func fetchCards(completion: @escaping (Result<[CardModel], Error>) -> Void) {
        
        
        
        
        db.collection("cards").getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error)
                completion(.failure(error))
                return
            }

            guard let documents = querySnapshot?.documents else {
                completion(.success([]))
                return
            }

            var cards = [CardModel]()
            let dispatchGroup = DispatchGroup()

            for document in documents {
                let data = document.data()
                let cardData: [String: Any] = [
                    "id": data["id"] as? String ?? "",
                    "cardHolder": data["cardHolder"] as? String ?? "",
                    "cardNumber": data["cardNumber"] as? String ?? "",
                    "expiryDate": (data["expiryDate"] as? Timestamp)?.dateValue() ?? Date(),
                    "balance": data["balance"] as? Double ?? 0.0,
                    "transactions": data["transactions"] as? [String] ?? []
                ]

                var card = CardModel(
                    id: cardData["id"] as! String,
                    cardHolder: cardData["cardHolder"] as! String,
                    cardNumber: cardData["cardNumber"] as! String,
                    expiryDate: cardData["expiryDate"] as! Date,
                    balance: cardData["balance"] as! Double,
                    transactions: []
                )

                dispatchGroup.enter()
                self.fetchTransactions(for: cardData["transactions"] as! [String]) { result in
                    switch result {
                    case .success(let transactions):
                        card.transactions = transactions
                        cards.append(card)
                    case .failure(let error):
                        print("Error fetching transactions: \(error.localizedDescription)")
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(.success(cards))
            }
        }
    }

    private func fetchTransactions(for transactionIDs: [String], completion: @escaping (Result<[Transaction], Error>) -> Void) {
        var transactions = [Transaction]()
        let dispatchGroup = DispatchGroup()

        for id in transactionIDs {
            dispatchGroup.enter()
            db.collection("transactions").document(id).getDocument { document, error in
                if let error = error {
                    completion(.failure(error))
                    dispatchGroup.leave()
                    return
                }

                if let document = document, document.exists {
                    let data = document.data() ?? [:]
                    let transaction = Transaction(
                        id: document.documentID,
                        category: data["category"] as? String ?? "",
                        iconName: data["iconName"] as? String ?? "",
                        amount: data["amount"] as? Double ?? 0.0,
                        createdAt: (data["createdAt"] as? Timestamp)?.dateValue() ?? Date()
                    )
                    transactions.append(transaction)
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(.success(transactions))
        }
    }
}
