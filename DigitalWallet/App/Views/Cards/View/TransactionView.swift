//
//  TransactionView.swift
//  DigitalWallet
//
//  Created by mert alp on 31.07.2024.
//

import SwiftUI

struct TransactionView: View {
    var transactions: [Transaction]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Transaction")
                .font(.headline)
                .padding(.horizontal)
            
            if transactions.isEmpty {
                ScrollView{
                    VStack {
                        Spacer()
                        Text("No past transactions")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
            } else {
                ScrollView{
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(transactions) { transaction in
                            TransactionItemView(transaction: transaction)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 0)
        .padding(.horizontal)
    }
}

struct TransactionItemView: View {
    var transaction: Transaction

    var body: some View {
        HStack {
            Image(systemName: transaction.iconName)
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
                .background(DWColors.primary.opacity(0.2))
                .cornerRadius(8)
            VStack(alignment: .leading) {
                Text(transaction.category)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(DateHelper.fullDateFormatter.string(from: transaction.createdAt))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Text("$\(String(transaction.amount))")
                .font(.headline)
                .foregroundColor(.red)
        }
    }
}

#Preview {
    TransactionView(transactions: [])
}
