//
//  CardProfileViewModel.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI

final class CardProfileViewModel: CardProfileViewModelInterface {
    @Published var cardInfo: CardInfo?
    @Published var cardBalance: CardBalance?
    var storage: CardStorage
    var cardNumber: String = ""
    
    var service: CardProfileServiceInterface
    
    init(cardNumber: String, storage: CardStorage, service: CardProfileServiceInterface = CardProfileService()) {
        self.storage = storage
        self.cardNumber = cardNumber
        self.service = service
    }
    
    func getInformation() async {
        do {
            cardInfo = try await service.getCardInformation(number: cardNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getBalance() async {
        do {
            cardBalance = try await service.getCardBalance(number: cardNumber)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteCard(cardNumber: String) {
        storage.removeCard(withNumber: cardNumber)
    }
}
