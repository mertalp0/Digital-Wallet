//
//  LoginCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 11.07.2024.
//


import SwiftUI
import UIKit
import Foundation

final class LoginCoordinator {

    var navigationController: UINavigationController
       
       init(navigationController: UINavigationController) {
           self.navigationController = navigationController
       }
       
       func start() {
           let loginViewModel = LoginViewModel(onTapRegister: pushRegisterView, onTapHome: pushHomeView)

           let loginView = LoginView(viewModel: loginViewModel).navigationBarBackButtonHidden(true)
           let loginViewController = UIHostingController(rootView: loginView)
           navigationController.pushViewController(loginViewController, animated: true)
       }

    
    func pushRegisterView() {
        let coordinator = RegisterCoordinator(navigationController: navigationController)
        let registerView = coordinator.makeViewController()
        navigationController.pushViewController(registerView, animated: true)
    }
    func pushHomeView() {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        let registerView = coordinator.makeViewController()
        navigationController.pushViewController(registerView, animated: true)
    }
   
}
