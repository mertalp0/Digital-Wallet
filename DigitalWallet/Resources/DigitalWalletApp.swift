//
//  DigitalWalletApp.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import SwiftUI



import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}


@main
struct DigitalWalletApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}



