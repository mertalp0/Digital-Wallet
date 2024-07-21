//
//  CustomButton.swift
//  DigitalWallet
//
//  Created by mert alp on 10.07.2024.
//
import SwiftUI
struct CustomButton : View {
    var title: String
    var color: Color? = DWColors.primary
    var size: ButtonSize 
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: {
                action()
            }) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
            }
            .buttonStyle(CustomButtonStyle(color: color!, size: size))
        }
    }
}

struct CustomButtonStyle: ButtonStyle {
    var color: Color
    var size: ButtonSize
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: size.size.width, height: size.size.height) 
            .padding()
            .background(configuration.isPressed ? color.opacity(0.7) : color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: configuration.isPressed ? 2 : 5, x: 0, y: 5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
