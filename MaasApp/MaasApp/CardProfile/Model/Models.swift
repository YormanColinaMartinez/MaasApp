//
//  Models.swift
//  MaasApp
//
//  Created by mac on 6/11/25.
//

import Foundation

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
