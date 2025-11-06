//
//  Card.swift
//  MaasApp
//
//  Created by mac on 6/11/25.
//

import Foundation

struct Card: Codable, Identifiable, Equatable, Hashable {
    var id: UUID { UUID() }
    let card: String
    let isValid: Bool
    let status: String
    let statusCode: Int
    
    init(card: String, isValid: Bool, status: String, statusCode: Int) {
        self.card = card
        self.isValid = isValid
        self.status = status
        self.statusCode = statusCode
    }
}
