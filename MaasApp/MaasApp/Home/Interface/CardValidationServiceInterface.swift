//
//  CardValidationServiceInterface.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import Foundation

protocol CardValidationServiceInterface {
    func fetchCardValidation(cardNumber: String) async throws -> Card?
}
