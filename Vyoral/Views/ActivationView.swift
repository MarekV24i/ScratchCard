//
//  ActivationView.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import SwiftUI

struct ActivationView: View {
    
    enum ScreenState {
        case unscratched
        case ready
        case activating
        case activated
    }
    @State var screenState: ScreenState = .unscratched {
        didSet {
            switch screenState {
            case .unscratched:
                labelString = String(localized: "activate_unscratched")
            case .ready:
                labelString = String(localized: "activation_ready")
                buttonString = String(localized: "activate_card")
            case .activating:
                labelString = ""
                buttonString = String(localized: "activating")
            case .activated:
                buttonString = String(localized: "card_activated")
            }
        }
    }
    
    @State private var labelString = ""
    @State private var buttonString = ""
    
    @State private var showingError = false
    
    // Injected view model
    @EnvironmentObject private var viewModel: ScratchCardViewModel
    
    var body: some View {
        VStack{
            Spacer()
            Text(labelString)
                .titleTextStyle()
            Button {
                buttonHandler()
            } label: {
                Text(buttonString).titleButtonStyle()
            }
            .allowsHitTesting(screenState == .ready)
            .defaultButtonStyle()
            .accessibilityIdentifier("activate_screen_button")
            .opacity(screenState == .unscratched ? 0 : 1)
            Spacer()
            LoaderView()
                .opacity(screenState == .activating ? 1 : 0)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .backgroundStyle()
        .onAppear() {
            updateState()
        }
        .onChange(of: viewModel.cardModel.cardState) { newValue in
            updateState()
        }
        .onDisappear() {
            viewModel.cancelScratching()
        }
        .alert(String(localized:"activation_error"), isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        }
    }
    
    // Button handling
    private func buttonHandler() {
        switch screenState {
        case .ready:
            screenState = .activating
            Task {
                do {
                    try await viewModel.activateCard()
                    screenState = .activated
                }
                catch {
                    showingError = true
                    screenState = .ready
                }
            }
        default:
            break
        }
    }
    
    // Screen state handling
    private func updateState() {
        switch viewModel.cardModel.cardState {
        case.unscratched:
            screenState = .unscratched
        case .scratched:
            screenState = .ready
        case .activated:
            screenState = .activated
        }
    }
}

#Preview {
    ActivationView().environmentObject(ScratchCardViewModel(activationService: O2ActivationAPI(), cardModel: ScratchCardModel()))
}
