//
//  CustomTextField.swift
//  DigitalWallet
//
//  Created by mert alp on 12.07.2024.
//

import SwiftUI

enum TextFieldType {
    case password
    case text
}

struct CustomTextField: View {
    var placeholder: String
    var textFieldType: TextFieldType? = .text
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        Group {
            if textFieldType == .text {
                TextField(placeholder, text: $text)
                    .modifier(TextFieldModifier(isFocused: isFocused))
            } else {
                SecureField(placeholder, text: $text)
                    .modifier(TextFieldModifier(isFocused: isFocused))
            }
        }
        .focused($isFocused)
    }
}
