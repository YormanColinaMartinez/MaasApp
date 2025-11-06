//
//  CardStorage.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import Foundation

class CardStorage: ObservableObject {
    private let key = "savedCards"

    func saveCard(_ card: Card) {
        var cards = getCards()
        if !cards.contains(where: { $0.card == card.card }) {
            cards.append(card)
            if let encoded = try? JSONEncoder().encode(cards) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }

    func getCards() -> [Card] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let cards = try? JSONDecoder().decode([Card].self, from: data) else {
            return []
        }
        return cards
    }

    func removeCard(withNumber cardNumber: String) {
        var cards = getCards()
        cards.removeAll { $0.card == cardNumber }
        
        if let encoded = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
