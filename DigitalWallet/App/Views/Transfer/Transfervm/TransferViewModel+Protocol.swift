//
//  TransferViewModel+Protocol.swift
//  DigitalWallet
//
//  Created by mert alp on 23.07.2024.
//

import Foundation
protocol TransferViewModelProtocol {
    var iban: String { get set }
    var amount: String { get set }
    var description: String { get set }
    var paymentType: PaymentType { get set }
    var showAlert: Bool { get set }
    var alertMessage: String { get set }
    
    func sendMoney()
}
