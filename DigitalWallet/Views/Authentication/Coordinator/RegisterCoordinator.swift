//
//  RegisterCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 17.07.2024.
//
import SwiftUI

class RegisterCoordinator: ObservableObject {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let view = RegisterView(viewModel: RegisterViewModel())
        let hostingVC = UIHostingController(rootView: view)
                DispatchQueue.main.async {
            hostingVC.navigationController?.navigationBar.isHidden = true
        }
        return hostingVC
    }
    
}
