//
//  MyCardCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 28.07.2024.
//

import Foundation
import SwiftUI

class CardsCoordinator: ObservableObject {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let view = CardsScene(
            viewModel: CardsViewModel())
        let hostingVC = UIHostingController(rootView: view)
                DispatchQueue.main.async {
            hostingVC.navigationController?.navigationBar.isHidden = true
        }
        return hostingVC
    }
    
}
