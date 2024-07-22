//
//  HomeCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import SwiftUI

class HomeCoordinator: ObservableObject {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let view = HomeView(
            viewModel: HomeViewModel(onTapHome: ontap ))
        let hostingVC = UIHostingController(rootView: view.navigationBarBackButtonHidden(true))
        return hostingVC
    }
    func ontap() {
        print("gdfh")
        let coordinator = TransferCoordinator(navigationController: navigationController)
        let registerView = coordinator.makeViewController()
        navigationController?.pushViewController(registerView, animated: true)
    }
}
