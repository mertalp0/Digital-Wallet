//
//  Color+Extension.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
      
        var cleanedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanedHex = cleanedHex.replacingOccurrences(of: "#", with: "")

      
        if cleanedHex.count == 6 {
            cleanedHex.append("FF")
        }

        
        var rgb: UInt64 = 0
        Scanner(string: cleanedHex).scanHexInt64(&rgb)

        let red = Double((rgb >> 24) & 0xFF) / 255.0
        let green = Double((rgb >> 16) & 0xFF) / 255.0
        let blue = Double((rgb >> 8) & 0xFF) / 255.0
        let alpha = Double(rgb & 0xFF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
