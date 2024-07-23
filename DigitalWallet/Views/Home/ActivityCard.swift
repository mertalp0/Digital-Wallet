//
//  ActivityCard.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import SwiftUI



struct ActivityCard: View {
    var type: ActivityCardType
    var action: () -> Void

    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                Image(systemName: type.imageName)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(15)
                    .foregroundColor(.white)
                    .background(DWColors.primary)
                    .cornerRadius(10)
                Text(type.title)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
            }
            .frame(width: Constant.width/4, height: Constant.width/3)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 0.5)
            .padding()
        }

    }
}

#Preview {
    ActivityCard(type: .insight , action: {})
}
