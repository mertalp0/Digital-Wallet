//
//  CardsViewModel+Protocol.swift
//  DigitalWallet
//
//  Created by mert alp on 1.08.2024.
//

import Foundation

protocol CardsViewModelProtocol {
    var cards: [CardModel] { get }
    var selectedCardIndex: Int { get set }
    func fetchCards()
    func addCard()
    func updateCard()
}
