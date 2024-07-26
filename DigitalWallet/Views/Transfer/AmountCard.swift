//
//  AmountCard.swift
//  DigitalWallet
//
//  Created by mert alp on 25.07.2024.
//

import SwiftUI

struct AmountCard: View {
    let amount: AmountCardType
    let action: () -> Void
    let isSelected: Bool

    @State private var animateColorChange = false

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Text(amount.displayText)
                .font(.headline)
                .frame(width: Constant.width / 3 - 20, height: 60)
                .background(isSelected ? Color.green.opacity(0.7) :DWColors.primary)
                .foregroundColor(DWColors.text)
                .cornerRadius(10)
                .padding(5)
                .scaleEffect(animateColorChange ? 1.1 : 1.0)
                .onChange(of: isSelected) { newValue in
                    withAnimation(.easeInOut(duration: 0.4)) {
                        animateColorChange.toggle()
                    }
                }
        }
    }
}
#Preview {
    AmountCard(amount: AmountCardType.fifty, action: {
        print("Card tapped")
    }, isSelected: true)
}
