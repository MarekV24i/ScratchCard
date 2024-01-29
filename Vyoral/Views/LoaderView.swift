//
//  LoaderView.swift
//  Vyoral
//
//  Created by Marek on 29.01.2024.
//

import SwiftUI

// Custom loading indicator
struct LoaderView: View {
    @State private var isLoading = false

    var body: some View {
        Circle()
            .trim(from: 0, to: 0.15)
            .stroke(Color.secondaryDark, lineWidth: 20)
            .frame(width: 100, height: 100)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
            .onAppear() {
                self.isLoading = true
            }
    }
}

#Preview {
    LoaderView()
}
