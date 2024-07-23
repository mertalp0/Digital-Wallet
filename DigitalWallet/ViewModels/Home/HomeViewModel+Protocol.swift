//
//  HomeViewModel+Protocol.swift
//  DigitalWallet
//
//  Created by mert alp on 23.07.2024.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var user: UserModel? { get set }
    var account: Account? { get set }
    
    func onTapTransferView()
    func fetchUser()
}
