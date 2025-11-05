//
//  FloatingButton.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI

struct FloatingButton: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                showAddCardAlert { newCard in
                    if let newCard = newCard {
                        Task {
                            if await viewModel.getValidation(cardNumber: newCard) {
                                viewModel.cards.append(newCard)
                            }
                        }
                    }
                }
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .clipShape(Circle())
                    .shadow(color: .green.opacity(0.6), radius: 10, x: 0, y: 4)
            }
            .padding()
        }
    }
}
