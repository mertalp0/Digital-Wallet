//
//  TransferService.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//
import Foundation
import FirebaseFirestore

class TransferService: TransferServiceProtocol {
    private let db = Firestore.firestore()
    
    func sendMoney(iban: String, senderUser: UserModel, amount: Double, date: Date, type: String, description: String, completion: @escaping (Bool?, Error?) -> Void) {
        
        let transferData: [String: Any] = [
            "iban": iban,
            "senderAccountId": senderUser.accountIban,
            "amount": amount,
            "date": Timestamp(date: date),
            "type": type,
            "description": description
        ]
        
        let senderAccountRef = db.collection("account").document(senderUser.accountIban)
        let receiverAccountRef = db.collection("account").document(iban)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            // Read sender account data
            let senderAccountDocument: DocumentSnapshot
            do {
                try senderAccountDocument = transaction.getDocument(senderAccountRef)
            } catch let error as NSError {
                print(error)
                errorPointer?.pointee = TransferServiceError(type: .unableToRetrieveSenderAccount).asNSError()
                return nil
            }
            
            // Read receiver account data
            let receiverAccountDocument: DocumentSnapshot
            do {
                try receiverAccountDocument = transaction.getDocument(receiverAccountRef)
            } catch let error as NSError {
                print(error)
                errorPointer?.pointee = TransferServiceError(type: .unableToRetrieveReceiverAccount).asNSError()
                return nil
            }

            // Validate and process sender account data
            guard let senderBalanceStr = senderAccountDocument.data()?["balance"] as? String,
                  let senderSpentStr = senderAccountDocument.data()?["spent"] as? String,
                  var senderBalance = Double(senderBalanceStr),
                  var senderSpent = Double(senderSpentStr) else {
                errorPointer?.pointee = TransferServiceError(type: .unableToRetrieveAccountData).asNSError()
                return nil
            }

            if senderBalance < amount {
                errorPointer?.pointee = TransferServiceError(type: .insufficientFunds).asNSError()
                return nil
            }

            // Validate and process receiver account data
            guard let receiverBalanceStr = receiverAccountDocument.data()?["balance"] as? String,
                  let receiverEarnedStr = receiverAccountDocument.data()?["earned"] as? String,
                  var receiverBalance = Double(receiverBalanceStr),
                  var receiverEarned = Double(receiverEarnedStr) else {
                errorPointer?.pointee = TransferServiceError(type: .unableToRetrieveAccountData).asNSError()
                return nil
            }
            
            // Update sender and receiver account balances
            senderBalance -= amount
            senderSpent += amount
            
            receiverBalance += amount
            receiverEarned += amount
            
            // Write updated balances to Firestore
            transaction.updateData([
                "balance": String(senderBalance),
                "spent": String(senderSpent)
            ], forDocument: senderAccountRef)
            
            transaction.updateData([
                "balance": String(receiverBalance),
                "earned": String(receiverEarned)
            ], forDocument: receiverAccountRef)
            
            // Create a new transfer document and get its ID
            let newTransferRef = self.db.collection("transfers").document()
            let newTransferID = newTransferRef.documentID
            
            // Add transfer data to the new document
            transaction.setData(transferData, forDocument: newTransferRef)
            
            // Add the new transfer ID to the transfers list of both sender and receiver accounts
            transaction.updateData([
                "transfers": FieldValue.arrayUnion([newTransferID])
            ], forDocument: senderAccountRef)
            
            transaction.updateData([
                "transfers": FieldValue.arrayUnion([newTransferID])
            ], forDocument: receiverAccountRef)
            
            return nil
        }) { (object, error) in
            if let error = error {
                completion(false, error)
            } else {
               
                completion(true, nil)
            }
        }
    }
}
