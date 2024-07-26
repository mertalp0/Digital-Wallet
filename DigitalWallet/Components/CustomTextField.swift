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
    var prefix: String? = nil

    var body: some View {
        Group {
            if textFieldType == .text {
                HStack {
                    if let prefix = prefix {
                        Text(prefix)
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                    }
                    TextField(placeholder, text: $text)
                       
                }.modifier(TextFieldModifier(isFocused: isFocused))
            } else {
                SecureField(placeholder, text: $text)
                    .modifier(TextFieldModifier(isFocused: isFocused))
            }
        }
        .focused($isFocused)
    }
}
