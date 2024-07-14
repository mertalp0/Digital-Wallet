//
//  RegisterView.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        VStack{
            CustomTextField(placeholder: "full name", text: $viewModel.fullname)
            CustomTextField(placeholder: "email", text: $viewModel.email)
            CustomTextField(placeholder: "password", text: $viewModel.password)
            CustomTextField(placeholder: "confirm password", text: $viewModel.confirmPassword)
            
            CustomCheckBox(isChecked: $viewModel.isChecked)
            CustomButton(title: "Register", size: .large) {
                viewModel.register { result in
                    
                }
                
            }
            Button(action: {
                
            }, label: {
                Text("Sign in")
            })
        }.alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(viewModel.alertMessage))
        })
    }
}

#Preview {
    RegisterView()
}

