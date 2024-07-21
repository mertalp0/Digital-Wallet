//
//  CustomCheckBox.swift
//  DigitalWallet
//
//  Created by mert alp on 14.07.2024.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(DWColors.primary)
        }
    }
}
