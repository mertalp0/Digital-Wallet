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
    @Published var selectedAmount : AmountCardType? = nil
    
    private var transferService: TransferService
    private var userService = UserService.shared
    
    init(transferService: TransferService = TransferService()) {
        self.transferService = transferService
    }
    
    func sendMoney() {
        let validation = Validator.validateTransfer(iban: "TR\(iban)", selectedAmount: selectedAmount, amount: amount, description: description)
           
           guard validation.isValid else {
               //TODO: Must be in localizable
               alertMessage = validation.errorMessage ?? "Unknown validation error"
               showAlert = true
               return
           }
           
           var finalAmount: Double?
           
           if selectedAmount != .other {
               if let displayText = selectedAmount?.displayText {
                   let newAmountString = String(displayText.dropFirst())
                   finalAmount = Double(newAmountString)
               }
           } else {
               finalAmount = Double(amount)
           }
           
           guard let validAmount = finalAmount else {
               //TODO: Must be in localizable
               alertMessage = "Invalid amount"
               showAlert = true
               return
           }
           
        let currentDate = Date()
        print(validAmount)
       
        let cleanIban = iban.replacingOccurrences(of: " ", with: "")
        print("TR\(cleanIban)")
        transferService.sendMoney(
            iban: "TR\(cleanIban)",
            senderUser: userService.user!,
            amount: validAmount,
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
