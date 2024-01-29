//
//  ScratchView.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import SwiftUI

struct ScratchView: View {
    enum ScreenState {
        case unscratched
        case scratching
        case scratched
        case activated
    }
    
    @State var screenState: ScreenState = .unscratched {
        didSet {
            switch screenState {
            case .unscratched:
                labelString = String(localized: "status_unscratched")
                buttonString = String(localized: "scratch_card")
            case .scratching:
                labelString = String(localized: "status_unscratched")
                buttonString = String(localized: "scratching")
            case .scratched:
                buttonString = String(localized: "scratching_finished")
            case .activated:
                labelString = ""
                buttonString = String(localized: "already_activated")
            }
        }
    }
    
    @State private var labelString = ""
    @State private var buttonString = ""
    
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
            .allowsHitTesting(screenState == .unscratched)
            .defaultButtonStyle()
            .accessibilityIdentifier("scratch_screen_button")
            Spacer()
            LoaderView()
                .opacity(screenState == .scratching ? 1 : 0)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .backgroundStyle()
        .onAppear() {
            updateState()
        }
        .onChange(of: viewModel.cardModel.cardState) { _ in
            updateState()
        }
        .onDisappear() {
            viewModel.cancelScratching()
        }
    }
    
    // Button handling
    private func buttonHandler() {
        switch screenState {
        case .unscratched:
            screenState = .scratching
            Task {
                await viewModel.scratchButtonTapped()
            }
            break
        default:
            break
        }
    }
    
    // Screen state handling
    private func updateState() {
        switch viewModel.cardModel.cardState {
        case.unscratched:
            screenState = .unscratched
        case .scratched(code: let code):
            labelString = code
            screenState = .scratched
        case .activated:
            screenState = .activated
        }
    }
}

#Preview {
    ScratchView().environmentObject(ScratchCardViewModel(activationService: O2ActivationAPI(), cardModel: ScratchCardModel()))
}
