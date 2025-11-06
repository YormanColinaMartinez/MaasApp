//
//  HomeViewModel.swift
//  MaasApp
//
//  Created by mac on 4/11/25.
//

import SwiftUI

final class HomeViewModel: HomeViewModelInterface, ObservableObject {
    @Published var selectedCard: Card?
    @Published var cards: [Card] = []
    @Published var showMap: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    
    private var service: CardValidationServiceInterface
    let storage: CardStorage
    
    init(service: CardValidationServiceInterface, storage: CardStorage) {
        self.service = service
        self.storage = storage
        self.cards = getCards()
    }
    
    func validateAndAddCard(_ cardNumber: String) async {
        let success = await getValidation(cardNumber: cardNumber)
        if !success {
            errorMessage = "No se pudo validar la tarjeta. Verifica el número e intenta de nuevo."
            showErrorAlert = true
        }
    }
    
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
        storage
    }
}
