//
//  HomeViewModel.swift
//  MaasApp
//
//  Created by mac on 4/11/25.
//

import Foundation

protocol HomeViewModelInterface: ObservableObject {
    var cards: [String] { get set }
    var selectedCard: String? { get set }
    func getValidation(cardNumber: String) async -> Bool
}

class HomeViewModel: HomeViewModelInterface {
    @Published var selectedCard: String?
    @Published var cards: [String] = []
    private var service: CardValidationServiceInterface
    
    init(service: CardValidationServiceInterface) {
        self.service = service
    }
    
    func getValidation(cardNumber: String) async -> Bool {
        do {
            let card = try await service.fetchCardValidation(cardNumber: cardNumber)
            return true
        } catch {
            return false
        }
    }
}
