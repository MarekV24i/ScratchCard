//
//  NetworkTests.swift
//  VyoralTests
//
//  Created by Marek on 29.01.2024.
//

import XCTest
@testable import Vyoral

final class NetworkTests: XCTestCase {

    func testNetworkService() async {
        do{
            let reponse = try await O2ActivationAPI().activateCard(code: "1234")
            XCTAssertNotNil(reponse)
        }
        catch {
            XCTFail()
        }
    }

}
