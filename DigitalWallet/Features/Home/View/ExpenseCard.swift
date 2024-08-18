//
//  ExpenseCard.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import SwiftUI

struct ExpenseCard: View {
    var spentAmount: String
    var earnedAmount: String
    var spentDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text(LocalizedStrings.Home.spentTitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("$\(spentAmount)")
                            .font(.title)
                            .bold()
                    }
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text(LocalizedStrings.Home.earnedTitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Circle()
                            .fill(Color(hex: "#5AA5E2"))
                            .frame(width: 10, height: 10)
                        Text("$\(earnedAmount)")
                            .font(.title)
                            .bold()
                    }
                }
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            VStack(alignment: .leading) {
                Text(spentDescription)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                Spacer()
                
                Text(LocalizedStrings.Home.moreInfoLink)
                    .font(.body)
                    .foregroundColor(DWColors.primary)
                    .padding([.bottom, .horizontal])
            }
        }
        .frame(width: Constant.width * 0.8, height: 200)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
