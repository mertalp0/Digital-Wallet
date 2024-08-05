//
//  TransferView.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//
import SwiftUI

struct TransferView: View {
    @ObservedObject var viewModel: TransferViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedPaymentMethod: PaymentMethod = .iban
    @FocusState private var focusedField: Field?

    enum Field {
        case iban
        case amount
        case description
    }

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                        }
                        Spacer()
                    }
                    Text(LocalizedStrings.Transfer.title)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            //TODO: must be in localizable
            Picker("Method", selection: $selectedPaymentMethod) {
                Text("IBAN").tag(PaymentMethod.iban)
                Text("QR").tag(PaymentMethod.qr)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 15)

            ScrollView {
                if selectedPaymentMethod == .iban {
                    VStack( spacing: 20) {
                        VStack(alignment: .leading) {
                            Text(LocalizedStrings.Transfer.ibanPlaceholder)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            
                            IbanTextField(text: $viewModel.iban)
                                .focused($focusedField, equals: .iban)
                                
                        }
                        VStack(alignment: .leading) {
                            Text(LocalizedStrings.Transfer.amountPlaceholder)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            VStack {
                                HStack {
                                    AmountCard(amount: .fifty, action: {
                                        handleAmountCardSelection(.fifty)
                                    }, isSelected: viewModel.selectedAmount == .fifty)
                                    AmountCard(amount: .oneHundred, action: {
                                        handleAmountCardSelection(.oneHundred)
                                    }, isSelected: viewModel.selectedAmount == .oneHundred)
                                    AmountCard(amount: .fiveHundred, action: {
                                        handleAmountCardSelection(.fiveHundred)
                                    }, isSelected: viewModel.selectedAmount == .fiveHundred)
                                }
                                HStack {
                                    AmountCard(amount: .oneThousand, action: {
                                        handleAmountCardSelection(.oneThousand)
                                    }, isSelected: viewModel.selectedAmount == .oneThousand)
                                    AmountCard(amount: .twoThousand, action: {
                                        handleAmountCardSelection(.twoThousand)
                                    }, isSelected: viewModel.selectedAmount == .twoThousand)
                                    AmountCard(amount: .other, action: {
                                        handleAmountCardSelection(.other)
                                    }, isSelected: viewModel.selectedAmount == .other)
                                }
                                .padding(.horizontal, 10)
                            }
                            if viewModel.selectedAmount == .other {
                                CustomTextField(placeholder: LocalizedStrings.Transfer.amountPlaceholder, text: $viewModel.amount ,prefix: "$")
                                    .focused($focusedField, equals: .amount)
        
                                    .padding(.vertical, 10)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(LocalizedStrings.Transfer.paymentType)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)

                            Picker(LocalizedStrings.Transfer.paymentType, selection: $viewModel.paymentType) {
                                ForEach(PaymentType.allCases, id: \.self) { type in
                                    Text(type.rawValue).tag(type)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .pickerStyle(MenuPickerStyle())
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(5)
                            .padding(.horizontal)
                            .accentColor(DWColors.primary)
                            .onTapGesture {
                                handlePaymentTypePickerTapped()
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(LocalizedStrings.Transfer.descriptionPlaceholder)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            CustomTextField(placeholder: LocalizedStrings.Transfer.descriptionPlaceholder, text: $viewModel.description)
                                .focused($focusedField, equals: .description)
                               
                        }
                        
                        VStack{CustomButton(title: LocalizedStrings.Transfer.sendButton, size: .large) {
                            viewModel.sendMoney()
                        }}
                        .padding(.top, 20)
                    }
                } else {
                    Text("QR PAGE")
                }
            }
            //TODO: must be in localizable

            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Transfer Status"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
        .padding()
    }

    private func handleAmountCardSelection(_ amount: AmountCardType) {
        focusedField = nil
        viewModel.selectedAmount = amount
    }

    private func handlePaymentTypePickerTapped() {
        focusedField = nil
    }
}

#Preview {
    TransferView(viewModel: TransferViewModel())
}
