//
//  CardProfileServiceInterface.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import Foundation

protocol CardProfileServiceInterface {
    func getCardInformation(number: String) async throws -> CardInfo
    func getCardBalance(number: String) async throws -> CardBalance
}
