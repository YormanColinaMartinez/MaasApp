//
//  CardView.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI

struct CardView: View {
    var cardNumber: String
    var width: CGFloat
    var onTap: (() -> Void)? = nil
    
    // MARK: - View
    var body: some View {
        GeometryReader { geometry in
            let cardWidth = geometry.size.width
            let cardHeight = geometry.size.height
            
            ZStack(alignment: .bottomLeading) {
                Image("tu-llave-verde")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: cardWidth)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                
                VStack {
                    Spacer()
                    
                    Text(cardNumber)
                        .font(.system(size: cardHeight * 0.05, weight: .regular))
                        .foregroundColor(.black)
                        .frame(width: cardWidth * 0.4, height: cardHeight * 0.13)
                        .padding(.bottom, cardHeight * 0.19)
                } .padding(.leading, 42)
            }
            .onTapGesture {
                onTap?()
            }
        }
        .frame(width: width, height: width * 0.6)
    }
}
