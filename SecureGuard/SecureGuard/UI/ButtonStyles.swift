//
//  ButtonStyles.swift
//  SecureGuard
//
//  Created by Liam Edwards on 22/12/22.
//

import Foundation
import SwiftUI

private struct PrimaryButton: ButtonStyle {
    private let backgroundColor = Color.accentColor
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.body.bold())
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? backgroundColor.opacity(0.8) : backgroundColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

extension Button {
    func primaryButton() -> some View {
        self
            .buttonStyle(PrimaryButton())
    }
}
