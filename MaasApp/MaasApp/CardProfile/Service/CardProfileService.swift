//
//  CardProfileService.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import Foundation

class CardProfileService {
    
    func cardGetInformation() async throws -> CardInfo {
        let url = URL(string: "https://osgqhdx2wf.execute-api.us-west-2.amazonaws.com/card/getInformation/1010000008582546")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJtYWFzIiwicHJpdmlsZWdlcyI6WyJDYXJkSW5mb3JtYXRpb25BY2Nlc3MiLCJSZWNoYXJnZUluZm9ybWF0aW9uQWNjZXNzIiwiUmVjaGFyZ2VDcmVhdGlvbkFjY2VzcyIsIlZTQU1SZWNoYXJnZXIiXSwiaXNzIjoicmJzYXMuY28iLCJjb21wYW55IjoiMTAwOCIsImV4cCI6MTc2MzQ3NTIwMSwiaWF0IjoxNzU4MjA0ODAxfQ.JSjxhto5B68HDRZsnA5uliDujEs1zyGJEfyn3cpEEu3VbY099hfhKwsJSXA93hFboQO0SO_8SYXPHmwmzjlUSDYb2OIZTiVOaVe5PXfxZeOpPrOcv_hwTtCumev0OGzWdloTShzw-PvfR3DmGpLM4WxJ5k_1yZ4j1SAKFdJeWTWSYbeH_M8NQDe6cv6rsEVOKRYu73EWoC2s7Ut7Wlf1rUz35Ljm6M_obLqAmOf35EQ7iCcmfBWjGO-BEFSi2BG2IxKYzMVXmtRxtcS5Yi-eoUxJ6nISNv6O7hRLRjgGpZhZoZWj4cqCF63SbgxAq_tzxLcJdvRSFT0cjkgHfITxSg", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(CardInfo.self, from: data)
    }
    
    func getCardBalance() async throws -> CardBalance {
        let url = URL(string: "https://osgqhdx2wf.execute-api.us-west-2.amazonaws.com/card/getInformation/1010000008582546")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJtYWFzIiwicHJpdmlsZWdlcyI6WyJDYXJkSW5mb3JtYXRpb25BY2Nlc3MiLCJSZWNoYXJnZUluZm9ybWF0aW9uQWNjZXNzIiwiUmVjaGFyZ2VDcmVhdGlvbkFjY2VzcyIsIlZTQU1SZWNoYXJnZXIiXSwiaXNzIjoicmJzYXMuY28iLCJjb21wYW55IjoiMTAwOCIsImV4cCI6MTc2MzQ3NTIwMSwiaWF0IjoxNzU4MjA0ODAxfQ.JSjxhto5B68HDRZsnA5uliDujEs1zyGJEfyn3cpEEu3VbY099hfhKwsJSXA93hFboQO0SO_8SYXPHmwmzjlUSDYb2OIZTiVOaVe5PXfxZeOpPrOcv_hwTtCumev0OGzWdloTShzw-PvfR3DmGpLM4WxJ5k_1yZ4j1SAKFdJeWTWSYbeH_M8NQDe6cv6rsEVOKRYu73EWoC2s7Ut7Wlf1rUz35Ljm6M_obLqAmOf35EQ7iCcmfBWjGO-BEFSi2BG2IxKYzMVXmtRxtcS5Yi-eoUxJ6nISNv6O7hRLRjgGpZhZoZWj4cqCF63SbgxAq_tzxLcJdvRSFT0cjkgHfITxSg", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(CardBalance.self, from: data)
    }
}
