//
//  CardProfileView.swift
//  MaasApp
//
//  Created by mac on 4/11/25.
//

import SwiftUI

struct CardProfileView: View {
    let cardNumber: String
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Detalles de la Tarjeta")
                .font(.title.bold())
            
            Text("Número de tarjeta:")
                .font(.headline)
            
            Text(cardNumber)
                .font(.title2.monospaced())
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
            
            Spacer()
        }
        .padding()
    }
}
