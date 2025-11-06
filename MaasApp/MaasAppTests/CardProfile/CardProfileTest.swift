//
//  CardProfileTest.swift
//  MaasAppTests
//
//  Created by mac on 6/11/25.
//

import XCTest
@testable import MaasApp

class CardProfileServiceTests: XCTestCase {
    
    var cardProfileService: CardProfileServiceInterface!
    
    override func setUp() {
        super.setUp()
        cardProfileService = CardProfileService()
    }
    
    override func tearDown() {
        cardProfileService = nil
        super.tearDown()
    }
    
    // Test: Sin token de API
    func testGetCardInformation_badServerResponse() async {
        do {
            _ = try await cardProfileService.getCardInformation(number: "123")
            XCTFail("Should have thrown error")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, .badServerResponse)
        }
    }
    
    // Test: URL inválida
    func testGetCardInformation_InvalidURL_ThrowsError() async {
        let invalidCardNumber = "%%%"
        
        do {
            _ = try await cardProfileService.getCardInformation(number: invalidCardNumber)
            XCTFail("Should have thrown error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
