//
//  RegisterView.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack{
            CustomTextField(placeholder: LocalizedStrings.Register.fullnamePlaceholder, text: $viewModel.fullname)
            CustomTextField(placeholder: LocalizedStrings.Register.emailPlaceholder, text: $viewModel.email)
            CustomTextField(placeholder: LocalizedStrings.Register.passwordPlaceholder, text: $viewModel.password)
            CustomTextField(placeholder: LocalizedStrings.Register.confirmPasswordPlaceholder, text: $viewModel.confirmPassword)
            CustomCheckBox(isChecked: $viewModel.isChecked)
            CustomButton(title: LocalizedStrings.Register.registerButton, size: .large) {
                viewModel.register { result in
                    // Handle registration result
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(viewModel.alertMessage))
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(viewModel: RegisterViewModel())
    }
}
