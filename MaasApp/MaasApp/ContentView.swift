//
//  ContentView.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    var service: CardValidationService = CardValidationService()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button(action: {
                Task {
                    do {

                        
                    } catch {
                        print("Error:", error)
                    }
                }
            }, label: {
                Text("Button, Press here")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
