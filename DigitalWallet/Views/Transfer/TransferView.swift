//
//  TransferView.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//
import SwiftUI

struct TransferView: View {
    @ObservedObject var viewModel: TransferViewModel

    var body: some View {
        VStack(spacing: 16) {
            CustomTextField(placeholder: "IBAN", text: $viewModel.iban)
                .keyboardType(.default)
            
            CustomTextField(placeholder: "Amount", text: $viewModel.amount)
                .keyboardType(.decimalPad)
            
            CustomTextField(placeholder: "Description", text: $viewModel.description)
                .keyboardType(.default)
            
            Picker("Payment Type", selection: $viewModel.paymentType) {
                Text("IBAN").tag(PaymentType.iban)
                Text("Card").tag(PaymentType.card)
                Text("Cash").tag(PaymentType.cash)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            CustomButton(title: "Send", size: .large) {
                viewModel.sendMoney() // Send money action
            }
            .padding()
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Transfer Status"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    TransferView(viewModel: TransferViewModel())
}
