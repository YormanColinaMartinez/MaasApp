//
//  TransportMapTest.swift
//  MaasAppTests
//
//  Created by mac on 6/11/25.
//

import XCTest
import CoreLocation
@testable import MaasApp

class OTPServiceTests: XCTestCase {
    
    var otpService: TransportMapServiceInterface!
    
    override func setUp() {
        super.setUp()
        otpService = TransportMapService()
    }
    
    override func tearDown() {
        otpService = nil
        super.tearDown()
    }
        
    // Test: Parseo de respuesta exitoso
    func testParseStopsResponse_ValidData_ReturnsNearbyStops() throws {
        let json = """
        [
            {
                "lat": 4.6097,
                "lon": -74.0817,
                "name": "Paradero Test"
            }
        ]
        """.data(using: .utf8)!
        let location = CLLocationCoordinate2D(latitude: 4.6097, longitude: -74.0817)
        
        let stops = try otpService.parseStopsResponse(data: json, userLocation: location)
        
        XCTAssertEqual(stops.count, 1)
        XCTAssertEqual(stops.first?.name, "Paradero Test")
    }
    
    // Test: Parseo con datos inválidos
    func testParseStopsResponse_InvalidData_ThrowsError() {
        let invalidJson = "invalid json".data(using: .utf8)!
        let location = CLLocationCoordinate2D(latitude: 4.6097, longitude: -74.0817)
        
        XCTAssertThrowsError(try otpService.parseStopsResponse(data: invalidJson, userLocation: location))
    }
}
