//
//  RegisterView.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Spacer()
            Text(LocalizedStrings.Register.welcome)
                .font(.largeTitle)
                .foregroundColor(DWColors.text)
            Text(LocalizedStrings.Register.provideDetails)
                .font(.subheadline)
                .foregroundColor(DWColors.text.opacity(0.7))
                .multilineTextAlignment(.center)
                .frame(width: 250, alignment: .center)
                .padding()
            Spacer().frame(height: 50)
            CustomTextField(placeholder: LocalizedStrings.Register.fullNamePlaceholder, text: $viewModel.fullname)
            CustomTextField(placeholder: LocalizedStrings.Register.emailAddressPlaceholder, text: $viewModel.email)
            CustomTextField(placeholder: LocalizedStrings.Register.passwordPlaceholder,textFieldType: .password, text: $viewModel.password)
            CustomTextField(placeholder: LocalizedStrings.Register.confirmPasswordPlaceholder, textFieldType: .password,text: $viewModel.confirmPassword)
            HStack {
                CheckBoxView(isChecked: $viewModel.isChecked)
                Text(LocalizedStrings.Register.termsConditions)
                    .font(.subheadline)
                    .foregroundColor(DWColors.text.opacity(0.7))
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            Spacer().frame(height: 20)
            CustomButton(title: LocalizedStrings.Register.signUpButton, size: .large) {
                viewModel.register { result in

                }
            }
            Spacer()
            HStack {
                Text(LocalizedStrings.Register.alreadyHaveAccount)
                    .foregroundColor(DWColors.text.opacity(0.7))
                Button(LocalizedStrings.Register.signIn) {
                //    viewModel.goToLogin()
                    self.presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(DWColors.primary)
            }
            Spacer()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertMessage))
        }
        .background(DWColors.background)
        .edgesIgnoringSafeArea(.all)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel())
    }
}
