//
//  TransferViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//
import Foundation

class TransferViewModel: ObservableObject {
    @Published var iban: String = ""
    @Published var amount: String = ""
    @Published var description: String = ""
    @Published var paymentType: PaymentType = .iban
    
    private var transferService: TransferService
    
    init(transferService: TransferService = TransferService()) {
        self.transferService = transferService
    }
    
    func sendMoney() {
        guard let amount = Double(amount) else {
            print("Invalid amount")
            return
        }
        
        let currentDate = Date()
        transferService.sendMoney(
            iban: iban,
            amount: amount,
            date: currentDate,
            type: paymentType.rawValue,
            description: description
        ) { success, error in
            if let error = error {
                print("Error sending money: \(error.localizedDescription)")
            } else if success == true {
                print("Money sent successfully!")
            }
        }
    }
}
