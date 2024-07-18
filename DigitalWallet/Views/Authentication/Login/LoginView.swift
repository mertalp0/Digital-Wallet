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
            CustomTextField(placeholder: "Email", text: $viewModel.email)
            CustomTextField(placeholder: "Password", text: $viewModel.password)
            CustomButton(title: "Login", size: .large) {
                viewModel.login { result in
                 
                    
                }
            }
            Button("go to Register") {
                 viewModel.goToRegister()
            }
            Button("go to Home") {
                viewModel.goToHome()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertMessage))
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(onTapRegister: {}, onTapHome: {}))
    }
}
