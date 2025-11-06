//
//  HomeView.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import SwiftUI
import UIKit

struct HomeView<ViewModel: HomeViewModelInterface>: View {
    
    @StateObject var viewModel: ViewModel
    @State private var showMap = false
    @State private var navigationPath = NavigationPath()
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(alignment: .leading) {
                Text("Mis Tarjetas")
                    .frame(height: 60)
                    .font(.title.bold().italic())
                    .padding(.leading, 40)
                
                ZStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 40) {
                            ForEach(viewModel.cards, id: \.self) { card in
                                CardView(cardNumber: card.card, width: UIScreen.main.bounds.width) {
                                    viewModel.selectedCard = card
                                }
                            }
                        }
                        .padding(.vertical, 60)
                    }
                    
                    Spacer()
                    
                    HStack(alignment: .bottom, spacing: 16) {
                        FloatingButton(
                            iconName: "plus",
                            backgroundColor: .green,
                            action: {
                                showAddCardAlert { newCard in
                                    if let newCard = newCard, !newCard.isEmpty {
                                        Task {
                                            let success = await viewModel.getValidation(cardNumber: newCard)
                                            if !success {
                                                errorMessage = "No se pudo validar la tarjeta. Verifica el número e intenta de nuevo."
                                                showErrorAlert = true
                                            }
                                        }
                                    }
                                }
                            }, buttonText: "Agregar Tarjeta"
                        )
                        
                        Spacer()
                        
                        FloatingButton(
                            iconName: "map",
                            backgroundColor: .blue,
                            action: {
                                navigationPath.append("mapView")
                            }, buttonText: "Mapa"
                        )
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .position(CGPoint(x: 150, y: UIScreen.main.bounds.height - 220))
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    
                }
            }
            .alert("Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "mapView" {
                    TransportMapView()
                }
            }
            .sheet(item: $viewModel.selectedCard) { card in
                let profileVM = CardProfileViewModel(cardNumber: card.card, storage: viewModel.getStorage())
                CardProfileView(viewModel: profileVM) {
                    viewModel.cards = viewModel.getStorage().getCards()
                }
            }
        }
    }
}
