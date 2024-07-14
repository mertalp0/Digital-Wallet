//
//  LoginView.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel() // Initialize 


    var body: some View {
        VStack(){
            
            Text("")
                .font(.caption2)
                .bold() // Placeholder text

            Text("") // Placeholder text
            
            CustomTextField(placeholder: "email", text: $viewModel.email)
            CustomTextField(placeholder: "password", text: $viewModel.password)
            CustomButton(title: "Login",  size: .large ,action: {
                viewModel.login { result in
                }
            })
      
           
        }.alert(isPresented: $viewModel.showAlert, content: {
            Alert(title: Text(viewModel.alertMessage))
        })
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
