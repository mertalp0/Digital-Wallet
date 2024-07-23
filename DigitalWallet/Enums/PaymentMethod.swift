//
//  PaymentMethod.swift
//  DigitalWallet
//
//  Created by mert alp on 23.07.2024.
//

import Foundation
enum PaymentMethod: String, Codable, CaseIterable {
    case qr = "QR"
    case iban = "IBAN"
}
