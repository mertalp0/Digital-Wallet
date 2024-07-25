//
//  HomeViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//
import Foundation
import SwiftUI

class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    @Published var user: UserModel?
    @Published var account: Account?
    @Published var isLoading: Bool = false // Add this line
    
    private let userService: UserServiceProtocol
    private let accountService: AccountServiceProtocol
    
    init(userService: UserServiceProtocol = UserService.shared, pushTransferView: @escaping () -> Void, accountService: AccountServiceProtocol = AccountService()) {
        self.pushTransferView = pushTransferView
        self.userService = userService
        self.accountService = accountService
        fetchUser()
    }
    
    private let pushTransferView: () -> Void

    func onTapTransferView() {
        pushTransferView()
    }
    
    func copyToClipboard(text: String) {
           UIPasteboard.general.string = text
       }
    
    func fetchUser() {
        isLoading = true // Start loading
        userService.fetchUser { [weak self] user, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching user: \(error.localizedDescription)")
                } else {
                    self?.fetchAccountInfo(accountId: user!.accountId)
                    self?.user = user
                }
                self?.isLoading = false // End loading
            }
        }
    }
    
    private func fetchAccountInfo(accountId: String) {
        accountService.fetchAccount(accountId: accountId) { [weak self] account, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error fetching account info: \(error.localizedDescription)")
                } else {
                    self?.account = account
                }
                self?.isLoading = false // End loading
            }
        }
    }
}
