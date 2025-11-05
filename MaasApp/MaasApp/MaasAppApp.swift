//
//  MaasAppApp.swift
//  MaasApp
//
//  Created by mac on 3/11/25.
//

import SwiftUI

@main
struct MaasAppApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(service: CardValidationService()))
        }
    }
}
