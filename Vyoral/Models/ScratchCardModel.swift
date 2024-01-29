//
//  ScratchCardModel.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

//Datamodel for scratch card
struct ScratchCardModel {
    
    enum CardState: Equatable {
        case unscratched
        case scratched(code: String)
        case activated
    }
    
    var cardState: CardState = .unscratched
    
}
