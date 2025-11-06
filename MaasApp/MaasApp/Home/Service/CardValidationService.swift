//
//  CardValidationService.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import Foundation

class CardValidationService: CardValidationServiceInterface {
    
    func fetchCardValidation(cardNumber: String) async throws -> Card? {
        let url = URL(string: "\(Endpoints.cardValidation.rawValue)\(cardNumber)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        guard let token = Bundle.main.object(forInfoDictionaryKey: "API_TOKEN") as? String else {
            throw URLError(.userAuthenticationRequired)
        }

        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        do {
            return try JSONDecoder().decode(Card.self, from: data)
        } catch {
            throw error
        }
    }
}
