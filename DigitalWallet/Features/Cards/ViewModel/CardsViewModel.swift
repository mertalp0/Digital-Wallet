//
//  MyCardViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 28.07.2024.
//
import Foundation
import Combine

class CardsViewModel: ObservableObject, CardsViewModelProtocol {
    @Published var cards: [CardModel] = []
    @Published var selectedCardIndex: Int = 0
    
    private let cardService: CardServiceProtocol
    
    init(cardService: CardServiceProtocol = CardService()) {
        self.cardService = cardService
        fetchCards()
    }
    
    func fetchCards() {
        cardService.fetchCards { [weak self] result in
            switch result {
            case .success(let cards):
                DispatchQueue.main.async {
                    print(cards)
                    self?.cards = cards
                }
            case .failure(let error):
                print("Error fetching cards: \(error.localizedDescription)")
            }
        }
    }
    
    func addCard() {
        // Yeni kart ekleme işlemi
    }
    
    func updateCard() {
        // Kart güncelleme işlemi
    }
    func deleteCard(){}
}
