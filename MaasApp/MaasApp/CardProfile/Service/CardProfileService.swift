//
//  CardProfileService.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import Foundation

class CardProfileService: CardProfileServiceInterface {    
    
    func getCardInformation(number: String) async throws -> CardInfo {
        let url = URL(string: "https://osgqhdx2wf.execute-api.us-west-2.amazonaws.com/card/getInformation/\(number)")!
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

        return try JSONDecoder().decode(CardInfo.self, from: data)
    }
    
    func getCardBalance(number: String) async throws -> CardBalance {
        let url = URL(string: "https://osgqhdx2wf.execute-api.us-west-2.amazonaws.com/card/getInformation/\(number)")!
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

        return try JSONDecoder().decode(CardBalance.self, from: data)
    }
}
