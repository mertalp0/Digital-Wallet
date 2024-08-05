//
//  CustomCreditCard.swift
//  DigitalWallet
//
//  Created by mert alp on 23.07.2024.
//

import Foundation
import SwiftUI

struct CustomCard: View {
    var card: CardModel
        
        var body: some View {
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading){
                        Text(card.cardHolder)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(card.cardNumber.formattedIban)
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.vertical, 4)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Good")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Text("THRU")
                            .font(.subheadline)
                            .foregroundColor(.white)
                   
                        Text(DateHelper.monthYearFormatter.string(from: card.expiryDate))
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                .padding(.bottom, 4)
                Text("Your Balance")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Text(String(card.balance))
                    .font(.largeTitle)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(DWColors.primary)
            .cornerRadius(10)
            .padding(.horizontal)
            .frame(height: 200)
        }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CustomCard(card: MockData.sampleCards[0])
    }
}
