//
//  CustomCheckBox.swift
//  DigitalWallet
//
//  Created by mert alp on 14.07.2024.
//

import SwiftUI

struct CustomCheckBox: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
               }) {
                   HStack {
                       Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                           .foregroundColor(isChecked ? .blue : .gray)
                       Text("By creating your account you have to agree with our Teams and Conditions.")
                   }.padding(15)
               }
               .buttonStyle(PlainButtonStyle())

    }
}

#Preview {
    CustomCheckBox(isChecked: .constant(true))
}
