//
//  ImageProcessor.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import UIKit

struct ScratchOperation {
    
    static func scratchCard() async throws -> String  {
        // Let's simulate heavy operation by some waiting
        try? await Task.sleep(until: .now + .seconds(2), clock: .continuous)
        
        //In real heavy operation there would be several points for checking if task was cancelled (in appropriate places), here is just one for example
        if Task.isCancelled {
            throw CancellationError()
        }
        return UUID().uuidString

    }
}
