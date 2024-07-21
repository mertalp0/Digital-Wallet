//
//  TextFieldModifier.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//

import Foundation
import SwiftUI

struct TextFieldModifier: ViewModifier {
    var isFocused: Bool

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(isFocused ? Color.blue : .clear, lineWidth: 1)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(isFocused ? DWColors.primary : .gray)
                            .opacity(0.2)
                    )
            )
            .padding(.horizontal)
            .foregroundColor(DWColors.text)
    }
}
