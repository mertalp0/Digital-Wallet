//
//  LoginViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI
import SwiftUI


class LoginViewModel: ObservableObject,LoginViewModelProtocol {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    private let goToRegisterView: () -> Void
    private let goToHomeView: () -> Void

    private var didCallOnAppearForTheFirstTime = false

    init( onTapRegister: @escaping () -> Void , onTapHome: @escaping ()-> Void ) {
        self.goToRegisterView = onTapRegister
        self.goToHomeView = onTapHome
    }

    func onAppear() {
        guard didCallOnAppearForTheFirstTime == false else {
            return
        }
        didCallOnAppearForTheFirstTime = true
    }

    func goToRegister() {
        goToRegisterView()
    }
    func goToHome() {
        goToHomeView()
    }
   
        

    func login(completion: @escaping (Result<UserModel, Error>) -> Void) {
   
        let validationResult = Validator.loginValid(email: email, password: password)
               
        guard validationResult.isValid else {
            self.alertMessage = validationResult.errorMessage ?? "Error"
            self.showAlert = true
            //TODO: Must be in DWErrors
            completion(.failure(NSError(domain: "LoginViewModel", code: 0, userInfo: [NSLocalizedDescriptionKey: self.alertMessage])))
            return
        }

    
        AuthenticationService.shared.login(email: email, password: password) {
            result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let user):
                    print(user.accountId)
                    completion(.success(user))
                    
                case .failure(let error):
                  
                    print(error)
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    completion(.failure(error))
                }
            }
        }
    }
}
