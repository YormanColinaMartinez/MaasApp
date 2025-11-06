//
//  TransportMapServiceInterface.swift
//  MaasApp
//
//  Created by mac on 6/11/25.
//

import Foundation
import CoreLocation

protocol TransportMapServiceInterface {
    func getNearbyStopsAsync(location: CLLocationCoordinate2D, radius: Int) async throws -> [NearbyStop]
    func parseStopsResponse(data: Data, userLocation: CLLocationCoordinate2D) throws -> [NearbyStop]
}
