//
//  MainScreenViewModel.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import Foundation

// View model for scratch card
@MainActor
class ScratchCardViewModel: ObservableObject {
    
    // Data model
    @Published var cardModel: ScratchCardModel
    
    // Network service
    private var activationService: NetworkRepository
    
    private var scratchTask: Task<String,Error>?
    
    public init(activationService: NetworkRepository, cardModel: ScratchCardModel) {
        self.activationService = activationService
        self.cardModel = cardModel
    }
    
    func scratchButtonTapped() async {
        guard cardModel.cardState == .unscratched else {
            return
        }
        
        scratchTask = Task {
            return try await ScratchOperation.scratchCard()
        }
        
        do {
            let code: String?
            try await code = scratchTask?.value
            if let codeUwnrapped = code {
                cardModel.cardState = .scratched(code: codeUwnrapped)
            }
            scratchTask = nil
        } catch {
            //Scratching was cancelled
            scratchTask = nil
        }
    }
    
    func cancelScratching() {
        scratchTask?.cancel()
    }
    
    func activateCard() async throws {
        switch cardModel.cardState {
        case .scratched(let code):
            let response = try await activationService.activateCard(code: code)
            
            if let versionString = response, let version = Double(versionString), version > MIN_ACTIVATION_VERSION {
                // Only activate when verison in response is higher than minimum requiered version
                cardModel.cardState = .activated
            }
            else {
                throw NetworkError.activationFailed
            }
        default:
            throw NetworkError.activationFailed
        }
    }
    
}
