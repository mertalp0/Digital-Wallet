//
//  AccountInfo.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import SwiftUI

struct ExpenseCard: View {
    var spentAmount: Double
    var earnedAmount: Double
    var spentDescription: String
    var moreInfoLink: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Spent")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                        Text("$\(Int(spentAmount))")
                            .font(.title)
                            .bold()
                    }
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Earned")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 10, height: 10)
                        Text("$\(Int(earnedAmount))")
                            .font(.title)
                            .bold()
                    }
                }
            }
            .padding([.top, .horizontal])
            
            Divider()
            
            Text(spentDescription)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Spacer()
            
            Text(moreInfoLink)
                .font(.body)
                .foregroundColor(.blue)
                .padding([.bottom, .horizontal])
        }
        .frame(width: Constant.width*0.8, height: 200)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}
