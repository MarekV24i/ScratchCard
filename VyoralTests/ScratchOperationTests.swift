//
//  ScratchingOperationTests.swift
//  VyoralTests
//
//  Created by Marek on 29.01.2024.
//

import XCTest
@testable import Vyoral

final class ScratchOperationTests: XCTestCase {


    func testScratching() async throws {
        let result = try await ScratchOperation.scratchCard()
        XCTAssert(!result.isEmpty)
    }
    
    func testCancel() async throws {
        let scratchTask = Task {
            return try await ScratchOperation.scratchCard()
        }
        scratchTask.cancel()
        
        do {
            let code: String?
            try await code = scratchTask.value
            if let _ = code {
                XCTFail()
            }
        } catch {
            //Scratching was cancelled
            XCTAssertTrue(true)
        }
    }
}
