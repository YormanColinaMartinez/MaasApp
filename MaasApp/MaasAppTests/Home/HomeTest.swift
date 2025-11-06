//
//  HomeTest.swift
//  MaasAppTests
//
//  Created by mac on 6/11/25.
//

import XCTest
@testable import MaasApp

class HomeTest: XCTestCase {
    
    var cardValidationService: CardValidationServiceInterface!
    
    override func setUp() {
        super.setUp()
        cardValidationService = CardValidationService()
    }
    
    override func tearDown() {
        cardValidationService = nil
        super.tearDown()
    }
    
    // Test: CardNumber vacío
    func testFetchCardValidation_EmptyCardNumber_ThrowsError() async {
        let emptyCardNumber = ""
    
        do {
            _ = try await cardValidationService.fetchCardValidation(cardNumber: emptyCardNumber)
            XCTFail("Should have thrown error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    // Test: Respuesta del servidor inválida
    func testFetchCardValidation_InvalidResponse_ThrowsError() async {
        let invalidCardNumber = "invalid123"
        
        do {
            _ = try await cardValidationService.fetchCardValidation(cardNumber: invalidCardNumber)
            XCTFail("Should have thrown error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
