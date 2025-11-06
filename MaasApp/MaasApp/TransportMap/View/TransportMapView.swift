//
//  TransportMapView.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI
import MapKit

struct TransportMapView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = TransportMapViewModel()

    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region,
                showsUserLocation: true,
                annotationItems: viewModel.nearbyStops) { stop in
                MapAnnotation(coordinate: stop.coordinate) {
                    VStack(spacing: 0) {
                        ZStack {
                            Circle()
                                .fill(Color.red.opacity(0.2))
                                .frame(width: 40, height: 40)
                            
                            Circle()
                                .fill(Color.red)
                                .frame(width: 30, height: 30)
                            
                            Image(systemName: "bus")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                        
                        Image(systemName: "triangle.fill")
                            .font(.system(size: 10))
                            .foregroundColor(.red)
                            .offset(y: -5)
                    }
                    .onTapGesture {
                        print("🚌 Paradero tocado: \(stop.name)")
                    }
                }
            }
            .ignoresSafeArea()
            .animation(.easeInOut(duration: 0.3), value: viewModel.nearbyStops.count)

            controlsView
        }
        .task {
            locationManager.start()
        }
        .onChange(of: locationManager.location) { location in
            guard let location else { return }
            Task {
                await viewModel.loadNearbyStops(location: location)
            }
        }
    }
    
    // MARK: - Controles superiores e inferiores
    private var controlsView: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("🚍 Paraderos Cercanos")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Radio: 1000 metros")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack {
                    Text("\(viewModel.nearbyStops.count)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text("Encontrados")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                .padding(8)
                .background(.ultraThinMaterial)
                .cornerRadius(8)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: refreshAction) {
                HStack {
                    Image(systemName: "arrow.clockwise.circle.fill")
                    Text("Buscar paraderos")
                }
                .fontWeight(.semibold)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
                .shadow(radius: 4)
            }
            .padding(.bottom)
        }
    }
    
    // MARK: - Acciones
    private func refreshAction() {
        if let location = locationManager.location {
            Task {
                await viewModel.loadNearbyStops(location: location)
            }
        } else {
            print("⚠️ Ubicación aún no disponible.")
        }
    }
}
