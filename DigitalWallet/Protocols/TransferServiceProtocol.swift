//
//  TransferServiceProtocol.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//

import Foundation

protocol TransferServiceProtocol {
    func sendMoney(iban: String,senderUser :UserModel, amount: Double, date: Date, type: String, description: String, completion: @escaping (Bool?, Error?) -> Void)
}
