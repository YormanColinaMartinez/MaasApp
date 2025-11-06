//
//  FloatingButton.swift
//  MaasApp
//
//  Created by mac on 5/11/25.
//

import SwiftUI

struct FloatingButton: View {
    let iconName: String
    let backgroundColor: Color
    let action: () -> Void
    let buttonText: String

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    Button(action: action) {
                        Image(systemName: iconName)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(backgroundColor)
                            .clipShape(Circle())
                            .shadow(color: .green.opacity(0.6), radius: 10, x: 0, y: 4)
                    }
                    .padding()
                    
                    Text(buttonText)
                        .bold()
                }
            }
        }
    }
}
