//
//  TransportMapModels.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import Foundation
import CoreLocation

struct NearbyStop: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let name: String
    let distance: Double
    let transportMode: String
}

struct OTPStop: Codable {
    let lat: Double
    let lon: Double
    let name: String?
}
