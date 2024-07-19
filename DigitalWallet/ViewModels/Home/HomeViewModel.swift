//
//  HomeViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var user: UserModel?
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService.shared) {
        self.userService = userService
        fetchUser()
    }
    
    private func fetchUser() {
        userService.fetchUser { [weak self] user, error in
            if let error = error {
                // Handle error, e.g., show an alert
                print("Error fetching user: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.user = user
                }
            }
        }
    }
 
}
