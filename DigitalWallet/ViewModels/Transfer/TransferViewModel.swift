//
//  TransferViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//

import Foundation

class TransferViewModel: ObservableObject, TransferViewModelProtocol {
    @Published var iban: String = ""
    @Published var amount: String = ""
    @Published var description: String = ""
    @Published var paymentType: PaymentType = .other
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    private var transferService: TransferService
    private var userService = UserService.shared
    
    init(transferService: TransferService = TransferService()) {
        self.transferService = transferService
    }
    
    func sendMoney() {
        let validation = Validator.transferValid(iban: iban, amount: amount, description: description)
        
        guard validation.isValid else {
            //TODO: Must be in localizable
            alertMessage = validation.errorMessage ?? "Unknown validation error"
            showAlert = true
            return
        }
       
        guard let amount = Double(amount) else {
            //TODO: Must be in localizable
            alertMessage = "Invalid amount"
            showAlert = true
            return
        }
        
        let currentDate = Date()
        transferService.sendMoney(
            iban: iban,
            senderUser: userService.user!,
            amount: amount,
            date: currentDate,
            type: paymentType.rawValue,
            description: description
        ) { success, error in
            if let error = error {
                //TODO: Must be in localizable
                self.alertMessage = "Error sending money: \(error.localizedDescription)"
                self.showAlert = true
            } else if success == true {
                self.amount = ""
                self.description = ""
                self.iban = ""
                //TODO: Must be in localizable
                self.alertMessage = "Money sent successfully!"
                self.showAlert = true
            }
        }
    }
}
