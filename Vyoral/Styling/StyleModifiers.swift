//
//  StyleModifiers.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import SwiftUI

struct TitleTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.textPrimary)
            .padding(30)
    }
}

struct TitleButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.textPrimary)
            .padding()
            .background(.clear)
            .frame(minWidth: 160)
    }
}

struct DefaultButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(gradient: Gradient(colors: [.buttonLight, .buttonDark, .buttonLight]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.black.opacity(0.2), lineWidth: 1)
            )
            .padding(10)
    }
}

struct BackgroundStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(gradient: Gradient(colors: [.secondaryDark, .secondaryLightest]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            )
    }
}

struct BorderedStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.1), lineWidth: 3)
            )
    }
}


