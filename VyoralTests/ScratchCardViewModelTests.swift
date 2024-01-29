//
//  ViewModelTests.swift
//  VyoralTests
//
//  Created by Marek on 29.01.2024.
//

import XCTest
import SwiftUI
@testable import Vyoral

// Tests for scratch card view model with mockup network service
final class ScratchCardViewModelTests: XCTestCase {
    
    //Test activation
    @MainActor func testActivationSuccess() async {
        var cardModel = ScratchCardModel()
        cardModel.cardState = .scratched(code: "1234")
        let viewModel = ScratchCardViewModel(activationService: MockUpNetworkRepositorySuccess(), cardModel: cardModel)
        
        do {
            try await viewModel.activateCard()
            XCTAssert(viewModel.cardModel.cardState == .activated)
        }
        catch {
            XCTFail()
        }
    }
    
    @MainActor func testActivationUnscratched() async {
        var cardModel = ScratchCardModel()
        cardModel.cardState = .unscratched
        let viewModel = ScratchCardViewModel(activationService: MockUpNetworkRepositorySuccess(), cardModel: cardModel)
        
        do {
            try await viewModel.activateCard()
            XCTAssert(viewModel.cardModel.cardState != .activated)
        }
        catch {
            XCTAssertTrue(true)
        }
    }
    
    @MainActor func testActivationLowVersion() async {
        var cardModel = ScratchCardModel()
        cardModel.cardState = .scratched(code: "1234")
        let viewModel = ScratchCardViewModel(activationService: MockUpNetworkRepositoryFail(), cardModel: cardModel)
        
        do {
            try await viewModel.activateCard()
            XCTAssert(viewModel.cardModel.cardState != .activated)
        }
        catch {
            XCTAssertTrue(true)
        }
    }
    
    @MainActor func testActivationNetworkError() async {
        var cardModel = ScratchCardModel()
        cardModel.cardState = .scratched(code: "1234")
        let viewModel = ScratchCardViewModel(activationService: MockUpNetworkRepositoryError(), cardModel: cardModel)
        
        do {
            try await viewModel.activateCard()
            XCTAssert(viewModel.cardModel.cardState != .activated)
        }
        catch {
            XCTAssertTrue(true)
        }
    }
    
    
    //Test scratching
    @MainActor func testScratchSuccess() async {
        let cardModel = ScratchCardModel()
        let viewModel = ScratchCardViewModel(activationService: MockUpNetworkRepositorySuccess(), cardModel: cardModel)
        
        await viewModel.scratchButtonTapped()
        XCTAssert(viewModel.cardModel.cardState != .unscratched)
        XCTAssert(viewModel.cardModel.cardState != .activated)
    }
    
    @MainActor func testScratchAlreadyActivated() async {
        var cardModel = ScratchCardModel()
        cardModel.cardState = .activated
        let viewModel = ScratchCardViewModel(activationService: MockUpNetworkRepositorySuccess(), cardModel: cardModel)
        
        await viewModel.scratchButtonTapped()
        XCTAssert(viewModel.cardModel.cardState == .activated)
    }
    
    @MainActor func testScratchAlreadyScratched() async {
        var cardModel = ScratchCardModel()
        cardModel.cardState = .scratched(code: "1234")
        let viewModel = ScratchCardViewModel(activationService: MockUpNetworkRepositorySuccess(), cardModel: cardModel)
        
        await viewModel.scratchButtonTapped()
        XCTAssert(viewModel.cardModel.cardState == .scratched(code: "1234"))
    }

}
