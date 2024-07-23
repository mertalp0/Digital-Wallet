//
//  LoginViewModel+Protocol.swift
//  DigitalWallet
//
//  Created by mert alp on 23.07.2024.
//

import Foundation

protocol LoginViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var alertMessage: String { get set }
    var showAlert: Bool { get set }
    
    func onAppear()
    func goToRegister()
    func goToHome()
    func login(completion: @escaping (Result<UserModel, Error>) -> Void)
}
