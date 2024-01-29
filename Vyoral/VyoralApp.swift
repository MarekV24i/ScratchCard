//
//  VyoralApp.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import SwiftUI

// Activate card only if response version is higher
let MIN_ACTIVATION_VERSION = 6.1

@main
struct VyoralApp: App {
    var body: some Scene {
        WindowGroup {
            // Inject view model, data model and dataSource
            MainScreen().environmentObject(ScratchCardViewModel(activationService: O2ActivationAPI(), cardModel: ScratchCardModel()))
        }
    }
}
