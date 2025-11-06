//
//  StopsListView.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI

struct StopsListView: View {
    let stops: [NearbyStop]
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(stops) { stop in
                HStack {
                    VStack(alignment: .leading) {
                        Text(stop.name)
                            .font(.headline)
                        Text("A \(Int(stop.distance)) metros")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Image(systemName: "bus")
                        .foregroundColor(.blue)
                }
            }
            .navigationTitle("Paraderos Cercanos")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Listo") { dismiss() }
                }
            }
        }
    }
}
