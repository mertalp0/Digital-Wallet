//
//  BankServiceProtocol.swift
//  DigitalWallet
//
//  Created by mert alp on 19.07.2024.
//

import Foundation

protocol AccountServiceProtocol {
    func fetchAccount(accountId: String , completion: @escaping (Account?, Error?) -> Void)
}
