//
//  AppCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 19.08.2024.
//
import UIKit

class AppCoordinator {
    var window: UIWindow
    var navigationController: UINavigationController
    var splashCoordinator: SplashCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        splashCoordinator = SplashCoordinator(navigationController: navigationController)
        splashCoordinator?.start()
    }
}
