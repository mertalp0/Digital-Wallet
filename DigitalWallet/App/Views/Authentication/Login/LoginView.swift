//
//  LoginView.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//
import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack {
            Spacer()
            Text(LocalizedStrings.Login.welcomeBack)
                .font(.largeTitle)
                .foregroundColor(DWColors.text)
            Text(LocalizedStrings.Login.signInToContinue)
                .font(.subheadline)
                .foregroundColor(DWColors.text.opacity(0.5))
                .padding()
            Spacer().frame(height: 50)
            CustomTextField(placeholder: LocalizedStrings.Login.emailPlaceholder, text: $viewModel.email)
            CustomTextField(placeholder: LocalizedStrings.Login.passwordPlaceholder, textFieldType: .password, text: $viewModel.password)
            HStack {
                Spacer()
                Button(LocalizedStrings.Login.forgotPassword) {
                 
                }
                .foregroundColor(DWColors.text.opacity(0.5))
                .font(.footnote)
                .padding(.trailing, 25)
            }
            Spacer().frame(height: 20)
            
            CustomButton(title: LocalizedStrings.Login.signInButton, size: .large) {
                viewModel.login { result in
                    switch result {
                    case .success:
                        viewModel.goToHome()
                    case .failure(let error):
                        print("Login failed with error: \(error.localizedDescription)")
                    }
                }
            }
            Spacer()
            HStack {
                Text(LocalizedStrings.Login.dontHaveAccount)
                    .foregroundColor(DWColors.text.opacity(0.5))
                Button(LocalizedStrings.Login.signUp) {
                    viewModel.goToRegister()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(onTapRegister: {}, onTapHome: {}))
    }
}
