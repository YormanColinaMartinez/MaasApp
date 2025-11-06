//
//  TransportMapService.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import Foundation
import CoreLocation

class OTPService {
    static let shared = OTPService()
    private let baseURL = "https://sisuotp.tullaveplus.gov.co/otp/routers/default"
    
    func getNearbyStopsAsync(location: CLLocationCoordinate2D, radius: Int = 1000) async throws -> [NearbyStop] {
        let urlString = "\(baseURL)/index/stops"
        
        guard var urlComponents = URLComponents(string: urlString) else {
            throw NSError(domain: "Invalid URL", code: 400)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)"),
            URLQueryItem(name: "radius", value: "\(radius)")
        ]
        
        guard let url = urlComponents.url else {
            throw NSError(domain: "Invalid URL", code: 400)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try parseStopsResponse(data: data, userLocation: location)
    }
    
    func parseStopsResponse(data: Data, userLocation: CLLocationCoordinate2D) throws -> [NearbyStop] {
        let stops = try JSONDecoder().decode([OTPStop].self, from: data)
        let userLocationObj = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        return stops.map { stop in
            let stopLocation = CLLocation(latitude: stop.lat, longitude: stop.lon)
            let distance = userLocationObj.distance(from: stopLocation)
            
            return NearbyStop(
                coordinate: CLLocationCoordinate2D(latitude: stop.lat, longitude: stop.lon),
                name: stop.name ?? "Paradero",
                distance: distance,
                transportMode: "BUS"
            )
        }
    }
}
