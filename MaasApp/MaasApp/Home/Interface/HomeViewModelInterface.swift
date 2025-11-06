//
//  HomeViewModelInterface.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI

protocol HomeViewModelInterface: ObservableObject {
    var cards: [Card] { get set }
    var selectedCard: Card? { get set }
    var showMap: Bool { get set }
    func getValidation(cardNumber: String) async -> Bool
    func getCards() -> [Card]
    func getStorage() -> CardStorage
}
