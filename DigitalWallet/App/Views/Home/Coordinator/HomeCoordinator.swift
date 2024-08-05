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
            viewModel: HomeViewModel(pushTransferView: pushTransferView, pushMyCardView: pushMyCardView))
        let hostingVC = UIHostingController(rootView: view)
                DispatchQueue.main.async {
            hostingVC.navigationController?.navigationBar.isHidden = true
        }
        return hostingVC
    }
    
    func pushTransferView() {
        let coordinator = TransferCoordinator(navigationController: navigationController)
        let transferView = coordinator.makeViewController()
        navigationController?.pushViewController(transferView, animated: true)
    }
    func pushMyCardView() {
        let coordinator = CardsCoordinator(navigationController: navigationController)
        let transferView = coordinator.makeViewController()
        navigationController?.pushViewController(transferView, animated: true)
    }
}
