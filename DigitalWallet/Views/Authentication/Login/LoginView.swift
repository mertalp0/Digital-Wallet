//
//  LoginView.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var fullName: String = "" // State for storing full name
    @State private var email: String = "" // State for storing full name

    var body: some View {
        VStack(alignment:.center){
            
            Text("Welcome!")
                .font(.caption2)
                .bold() // Placeholder text

            Text("Please provide following details for your new account") // Placeholder text
            
            CustomTextField(placeholder: "email", text: $fullName)
            CustomTextField(placeholder: "password", text: $email)
            CustomButton(title: "Login", action: {
                
            }, size: .large)
      
           
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
