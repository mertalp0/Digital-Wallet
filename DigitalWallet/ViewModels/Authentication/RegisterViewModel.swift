//
//  RegisterViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var fullname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isChecked : Bool = false
    @Published var isLoading: Bool = false
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    

    
    func register(completion: @escaping (Result<Bool, Error>) -> Void) {
        // Validate inputs before registration
        
        let validationResult = Validator.registerValid(fullname: fullname, email: email, password: password, confirmPassword: confirmPassword)
               
               guard validationResult.isValid else {
                   self.alertMessage = validationResult.errorMessage ?? "Error"
                   self.showAlert = true
                   completion(.failure(NSError(domain: "RegisterViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: self.alertMessage])))
                   return
               }
        guard isChecked else {
            self.alertMessage = "Dont check"
            self.showAlert = true
            completion(.failure(NSError(domain: "RegisterViewModel", code: 1, userInfo: [NSLocalizedDescriptionKey: self.alertMessage])))
            return
        }
        isLoading = true
        AuthenticationService.shared.register(fullname: fullname, email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let success):
                  
                    self.fullname = ""
                    self.email = ""
                    self.password = ""
                    self.confirmPassword = ""
                    self.isChecked = false
                    
                    self.alertMessage = "Please verify your email address"
                    self.showAlert = true
                    completion(.success(success))
                    
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    completion(.failure(error))
                }
            }
        }
    }
    
   
}
