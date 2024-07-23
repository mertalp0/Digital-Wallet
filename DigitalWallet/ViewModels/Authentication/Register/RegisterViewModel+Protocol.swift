//
//  RegisterViewModel+Protocol.swift
//  DigitalWallet
//
//  Created by mert alp on 23.07.2024.
//

import Foundation

protocol RegisterViewModelProtocol: ObservableObject {
    var fullname: String { get set }
    var email: String { get set }
    var password: String { get set }
    var confirmPassword: String { get set }
    var isChecked: Bool { get set }
    var isLoading: Bool { get set }
    var alertMessage: String { get set }
    var showAlert: Bool { get set }

    func register(completion: @escaping (Result<Bool, Error>) -> Void)
}
