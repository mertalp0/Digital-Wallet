//
//  IbanTextField.swift
//  DigitalWallet
//
//  Created by mert alp on 25.07.2024.
//
import SwiftUI

struct IbanTextField: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    private let prefix: String = "TR"
    private let maxCharacters = 24

    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            HStack {
                Text(prefix)
                    .foregroundColor(.gray)
                    .padding(.leading, 8)
                TextField("", text: $text)
                    .padding(.leading, 4)
                    .onChange(of: text) { newValue in
                        if (newValue.count<=32){
                            print(newValue.count)
                            let formattedText = formatIban(newValue)
                            limitText(formattedText)
                        }
                        else{
                            text = String(newValue.prefix(32))
                        }
                    }
            }
            .modifier(TextFieldModifier(isFocused: isFocused))
            .focused($isFocused)
            
            Text("\(text.replacingOccurrences(of: " ", with: "").count)/\(maxCharacters)")
                .font(.caption)
                .foregroundColor(text.count <= 31 ? .red : .green)
                .padding(.trailing, 20)
        }
    }
    
    private func formatIban(_ text: String) -> String {
        let digitsOnly = text.replacingOccurrences(of: " ", with: "")
        let formatted = "  \(digitsOnly)".chunked(into: 4).joined(separator: " ")
        return formatted
    }
    
    private func limitText(_ newValue: String) {
        let strippedText = newValue.replacingOccurrences(of: " ", with: "")
        if strippedText.count > maxCharacters {
            text = String(newValue.prefix(maxCharacters + (maxCharacters / 4)))
        } else {
            text = newValue
        }
    }
}



struct IbanTextField_Previews: PreviewProvider {
    static var previews: some View {
        IbanTextField(text: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
