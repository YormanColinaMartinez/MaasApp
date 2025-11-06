//
//  MaasAppApp.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import SwiftUI

@main
struct MaasAppApp: App {
    private var storage = CardStorage()
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(service: CardValidationService(), storage: storage))
                .environmentObject(storage)
        }
    }
}
