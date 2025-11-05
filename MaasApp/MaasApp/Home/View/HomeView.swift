//
//  HomeView.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import SwiftUI
import UIKit

extension String: Identifiable {
    public var id: String { self }
}

struct HomeView<ViewModel: HomeViewModelInterface>: View {

    @StateObject var viewModel: ViewModel
        
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mis Tarjetas")
                .frame(height: 60)
                .font(.title.bold().italic())
                .padding(.leading, 40)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 40) {
                    ForEach(viewModel.cards, id: \.self) { card in
                        CardView(cardNumber: card, width: UIScreen.main.bounds.width) {
                            viewModel.selectedCard = card
                        }
                    }
                }
                .padding(.vertical, 60)
            }
            
            Spacer()
            

        }
        .sheet(item: $viewModel.selectedCard) { card in
            CardProfileView(cardNumber: card)
        }
    }
}
