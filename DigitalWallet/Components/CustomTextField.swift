//
//  CustomTextField.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import SwiftUI
struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(isFocused ? Color.blue : .clear, lineWidth: 1) // Change border color when focused
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(isFocused ? .blue  : .gray)
                            .opacity(0.2) // Opacity for background color
                    )
            )
            .padding(.horizontal)
            .foregroundColor(.black) // Text color
            .focused($isFocused)
    }
}
