//
//  PageControl.swift
//  DigitalWallet
//
//  Created by mert alp on 31.07.2024.
//

import SwiftUI

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? DWColors.primary : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
        .padding(.vertical)
    }
}


#Preview {
    PageControl(numberOfPages: 2, currentPage: .constant(3))
}
