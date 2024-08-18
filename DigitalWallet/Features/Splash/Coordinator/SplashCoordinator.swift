//
//  SplashCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 19.08.2024.
//
import UIKit
import SwiftUI

class SplashCoordinator {
    var navigationController: UINavigationController
    var loginCoordinator: LoginCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let splashView = SplashView()
        let splashViewController = UIHostingController(rootView: splashView)
        navigationController.pushViewController(splashViewController, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) { // 2 saniye splash ekranında kalacak
            self.showLogin()
        }
    }
    
    private func showLogin() {
        loginCoordinator = LoginCoordinator(navigationController: navigationController)
        loginCoordinator?.start()
    }
}
