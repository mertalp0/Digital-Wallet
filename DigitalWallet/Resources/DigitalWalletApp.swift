//
//  DigitalWalletApp.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//
import SwiftUI
import Firebase

@main
struct DigitalWalletApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RegisterView()
        }
    }
}
