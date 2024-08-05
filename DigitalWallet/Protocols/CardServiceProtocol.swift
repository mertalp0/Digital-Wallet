//
//  CardServiceProtocol.swift
//  DigitalWallet
//
//  Created by mert alp on 1.08.2024.
//

import Foundation

protocol CardServiceProtocol {
    func fetchCards(completion: @escaping (Result<[CardModel], Error>) -> Void) 
}
