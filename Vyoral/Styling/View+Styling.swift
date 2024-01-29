//
//  View+Styling.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import SwiftUI

// Make styling modifiers easier to use
extension View {
    func titleTextStyle() -> some View {
        modifier(TitleTextStyle())
    }
    
    func titleButtonStyle() -> some View {
        modifier(TitleButtonStyle())
    }
    
    func defaultButtonStyle() -> some View {
        modifier(DefaultButtonStyle())
    }
    
    func backgroundStyle() -> some View {
        modifier(BackgroundStyle())
    }
    
    func borderedStyle() -> some View {
        modifier(BorderedStyle())
    }
}
