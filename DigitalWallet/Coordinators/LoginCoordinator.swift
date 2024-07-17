//
//  AppCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 11.07.2024.
//

import Foundation
import SwiftUI

final class LoginCoordinator {

    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }()

    func makeViewController() -> UIViewController {
        let viewModel = LoginViewModel(authService: AuthenticationService.shared)
        let loginView = LoginView(viewModel: viewModel)
        let hostingVC = UIHostingController(rootView: loginView)
        navigationController.setViewControllers([hostingVC], animated: false)
        return navigationController
    }

    func pushRegisterView() {
        let coordinator = RegisterCoordinator(navigationController: navigationController)
        let registerView = coordinator.makeViewController()
        navigationController.pushViewController(registerView, animated: true)
    }
}
