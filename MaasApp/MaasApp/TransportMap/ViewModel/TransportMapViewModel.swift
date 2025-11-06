//
//  TransportMapViewModel.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import Foundation
import MapKit

class TransportMapViewModel: ObservableObject {
    @Published var nearbyStops: [NearbyStop] = []
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 4.6097, longitude: -74.0817),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    var service: TransportMapServiceInterface
    
    init(service: TransportMapServiceInterface = TransportMapService()) {
        self.service = TransportMapService()
    }
    
    @MainActor
    func loadNearbyStops(location: CLLocationCoordinate2D) async {
        do {
            nearbyStops = try await service.getNearbyStopsAsync(location: location, radius: 1000)
            region.center = location
        } catch {
            print("Error cargando paraderos: \(error)")
        }
    }
}
