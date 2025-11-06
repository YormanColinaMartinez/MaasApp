//
//  HomeView.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import SwiftUI
import UIKit

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerView
                ZStack {
                    listView

                    Spacer()
                    
                    floatingbuttons
                }
            }
            .alert("Error", isPresented: $viewModel.showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
            .sheet(isPresented: $viewModel.showMap) {
                TransportMapView()
            }
            .sheet(item: $viewModel.selectedCard) { card in
                let profileVM = CardProfileViewModel(cardNumber: card.card, storage: viewModel.storage)
                CardProfileView(viewModel: profileVM) {
                    viewModel.cards = viewModel.getStorage().getCards()
                }
            }
        }
    }
    
    private var headerView: some View {
        Text("Mis Tarjetas")
            .frame(height: 60)
            .font(.title.bold().italic())
            .padding(.leading, 40)
    }
    
    private var listView: some View {
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
    }
    
    private var floatingbuttons: some View {
        HStack(alignment: .bottom, spacing: 16) {
            FloatingButton(
                iconName: "plus",
                backgroundColor: .green,
                action: {
                    AlertController.showAddCardAlert { newCard in
                        if let newCard = newCard, !newCard.isEmpty {
                            Task {
                                await viewModel.validateAndAddCard(newCard)
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
                    viewModel.showMap = true
                }, buttonText: "Mapa"
            )
        }
        .frame(width: UIScreen.main.bounds.width)
        .position(CGPoint(x: 150, y: UIScreen.main.bounds.height - 220))
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }
}
