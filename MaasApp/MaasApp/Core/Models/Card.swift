//
//  Card.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
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

struct CardInfo: Codable {
    let cardNumber: String
    let profileCode: String
    let profile: String
    let profile_es: String
    let bankCode: String
    let bankName: String
    let userName: String
    let userLastName: String
}

struct CardBalance: Codable {
    let card: String
    let balance: Double
    let balanceDate: String
    let virtualBalance: Double
    let virtualBalanceDate: String
}

extension String: Identifiable {
    public var id: String { self }
}
