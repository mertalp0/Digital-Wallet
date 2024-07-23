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
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    HStack{
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding()
                        }
                        Spacer()
                    }
                    Text(LocalizedStrings.Transfer.title)
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            Picker("Method", selection: $selectedPaymentMethod) {
                Text("IBAN").tag(PaymentMethod.iban)
                           Text("QR").tag(PaymentMethod.qr)}
                       .pickerStyle(SegmentedPickerStyle())
                       .padding()
            ScrollView {
                if selectedPaymentMethod == .iban {
                    VStack {
                    VStack(alignment: .leading, spacing: 16) {
                        VStack(alignment: .leading) {
                            Text(LocalizedStrings.Transfer.ibanPlaceholder)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            CustomTextField(placeholder: LocalizedStrings.Transfer.ibanPlaceholder, text: $viewModel.iban)
                        }
                        VStack(alignment: .leading) {
                            Text(LocalizedStrings.Transfer.amountPlaceholder)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            CustomTextField(placeholder: LocalizedStrings.Transfer.amountPlaceholder, text: $viewModel.amount)
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
                        }
                        VStack(alignment: .leading) {
                            Text(LocalizedStrings.Transfer.descriptionPlaceholder)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                            CustomTextField(placeholder: LocalizedStrings.Transfer.descriptionPlaceholder, text: $viewModel.description)
                        }
                    }

                    CustomButton(title: LocalizedStrings.Transfer.sendButton, size: .large) {
                        viewModel.sendMoney()
                    }
                    }}else{
                        Text("QR PAGE ")
                    }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("Transfer Status"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    TransferView(viewModel: TransferViewModel())
}
