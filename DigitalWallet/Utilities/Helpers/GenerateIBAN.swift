//
//  GenerateIBAN.swift
//  DigitalWallet
//
//  Created by mert alp on 19.07.2024.
//

import Foundation
func generateRandomIBAN() -> String {
    let countryCode = "TR"
    let checkDigits = "70"  // Sabit kontrol rakamları
    let bankCode = String(format: "%05d", Int.random(in: 0..<100000))
    let branchCode = String(format: "%05d", Int.random(in: 0..<100000))
    let accountNumber = String(format: "%010d", Int.random(in: 0..<10000000000))
    let iban = countryCode + checkDigits + bankCode + branchCode + accountNumber
    return iban
}

