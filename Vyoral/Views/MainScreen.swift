//
//  File.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import SwiftUI

struct MainScreen: View {
    
    // Injected view model
    @EnvironmentObject private var viewModel: ScratchCardViewModel
        
    @State var showScratchScreen = false
    @State var showActivationScreen = false
    
    @State private var labelString = ""
        
    public var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Text(labelString)
                        .titleTextStyle()
                    
                  
                        Button {
                            showScratchScreen = true
                        } label: {
                            Text("scratch_card").titleButtonStyle()
                        }
                        .defaultButtonStyle()
                        .accessibilityIdentifier("scratch_button")
                        .navigationDestination(
                            isPresented: $showScratchScreen) {
                                ScratchView()
                            }

                    Button {
                        showActivationScreen = true
                    } label: {
                        Text("activate_card").titleButtonStyle()
                    }
                    .defaultButtonStyle()
                    .accessibilityIdentifier("activate_button")
                    .navigationDestination(
                        isPresented: $showActivationScreen) {
                            ActivationView()
                        }
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.top, 30)
                .padding(.bottom, 30)
                .frame(maxWidth: 350)
                .borderedStyle()
             
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .backgroundStyle()
            .onAppear() {
                //Fix known SwiftUI rotation glitch (underlaying system white background can be seen)
                if let window = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first {
                    window.rootViewController?.view.backgroundColor = UIColor(Color.secondaryLight)
                }
                updateState()
            }
            .onChange(of: viewModel.cardModel.cardState) { _ in
                updateState()
            }
        }

    }
    
    // Handle card state
    private func updateState() {
        switch viewModel.cardModel.cardState {
        case .scratched:
            labelString = String(localized: "status_scratched")
        case .unscratched:
            labelString = String(localized: "status_unscratched")
        case .activated:
            labelString = String(localized: "status_activated")
        }
    }

}

#Preview {
    MainScreen().environmentObject(ScratchCardViewModel(activationService: O2ActivationAPI(), cardModel: ScratchCardModel()))
}
