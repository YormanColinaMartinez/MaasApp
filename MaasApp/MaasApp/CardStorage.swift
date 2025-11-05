//
//  CardStorage.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import Foundation

struct CardStorage {
    private let key = "savedCards"

    func saveCard(_ cardNumber: String) {
        var cards = getCards()
        if !cards.contains(cardNumber) {
            cards.append(cardNumber)
            UserDefaults.standard.set(cards, forKey: key)
        }
    }

    func getCards() -> [String] {
        return UserDefaults.standard.stringArray(forKey: key) ?? []
    }

    func removeCard(_ cardNumber: String) {
        var cards = getCards()
        cards.removeAll { $0 == cardNumber }
        UserDefaults.standard.set(cards, forKey: key)
    }

    func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
