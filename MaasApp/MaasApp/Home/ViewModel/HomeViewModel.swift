//
//  HomeViewModel.swift
//  MaasApp
//
//  Created by mac on 4/11/25.
//

import SwiftUI

class HomeViewModel: HomeViewModelInterface {
    @Published var selectedCard: Card?
    @Published var cards: [Card] = []
    @Published var showMap: Bool = false
    private var service: CardValidationServiceInterface
    var storage: CardStorage
    
    init(service: CardValidationServiceInterface) {
        self.service = service
        self.storage = CardStorage()
        self.cards = storage.getCards()
    }
    
    @MainActor
    func getValidation(cardNumber: String) async -> Bool {
        do {
            guard let card = try await service.fetchCardValidation(cardNumber: cardNumber) else { return false }
            storage.saveCard(card)
            cards = storage.getCards()
            return true
        } catch {
            return false
        }
    }
    
    func getCards() -> [Card] {
        storage.getCards()
    }
    
    func saveCard(card: Card) {
        storage.saveCard(card)
    }
    
    func getStorage() -> CardStorage {
        return storage
    }
}
