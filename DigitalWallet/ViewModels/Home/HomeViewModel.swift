//
//  HomeViewModel.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var user: UserModel?
    @Published var account: Account?
    
    private let userService: UserServiceProtocol
    private let accountService: AccountServiceProtocol
    
    init(userService: UserServiceProtocol = UserService.shared , pushTransferView: @escaping ()-> Void, accountService : AccountServiceProtocol = AccountService()) {
        self.pushTransferView = pushTransferView
        self.userService = userService
        self.accountService = accountService
        fetchUser()
       
    }
    
    private let pushTransferView: () -> Void

    func onTapTransferView() {
        pushTransferView()
    }
    
     func fetchUser() {
        userService.fetchUser { [weak self] user, error in
            if let error = error {
            
                print("Error fetching user: \(error.localizedDescription)")
            } else {
                self?.fetchAccountInfo(accountId: user!.accountId)
                DispatchQueue.main.async {
                    self?.user = user
                   
                }
            }
        }
    }
    
    private func fetchAccountInfo(accountId:String) {
        accountService.fetchAccount(accountId: accountId) { [weak self] account, error in
            if let error = error {
                
                print("Error fetching user: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self?.account = account
                }
            }
        }
     
    }
 
}
