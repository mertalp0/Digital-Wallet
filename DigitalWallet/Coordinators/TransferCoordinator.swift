//
//  TransferCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 21.07.2024.
//
//
//  LoginCoordinator.swift
//  DigitalWallet
//
//  Created by mert alp on 11.07.2024.
//

import SwiftUI

class TransferCoordinator: ObservableObject {
    
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func makeViewController() -> UIViewController {
        let view = TransferView(
            viewModel: TransferViewModel())
        let hostingVC = UIHostingController(rootView: view)
        return hostingVC
    }
    
}
