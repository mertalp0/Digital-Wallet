//
//  LoginView.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//
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
            CustomTextField(placeholder: LocalizedStrings.Login.emailPlaceholder, text: $viewModel.email)
            CustomTextField(placeholder: LocalizedStrings.Login.passwordPlaceholder, text: $viewModel.password)
            CustomButton(title: LocalizedStrings.Login.loginButton, size: .large) {
                viewModel.login { result in
                    switch result {
                    case .success:
                        viewModel.goToHome()
                    case .failure(let error):
                        print("Login failed with error: \(error.localizedDescription)")
                    }
                }
            }
            Button(LocalizedStrings.Login.goToRegisterButton) {
                viewModel.goToRegister()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(LocalizedStrings.Login.alertTitle))
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(onTapRegister: {}, onTapHome: {}))
    }
}
