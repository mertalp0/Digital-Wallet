//
//  HomeView.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.blue
                    .frame(height: Constant.height/3)
                Color.clear
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(alignment:.center,spacing: 20){
                HStack(){
                    VStack(alignment:.leading){
                        Text("$7,425")
                        Text("Available balance")
                    }
                    Spacer()
                    Image(systemName: "person.circle")
                           .font(.system(size: 35))
                }.padding(.horizontal, 50)
                .padding(.vertical, 15)
                HStack(alignment:.center){
                    ExpenseCard(
                               spentAmount: 1460,
                               earnedAmount: 2730,
                               spentDescription: "You spent $2,732 on dining out this month.\nLet's try to make it lower",
                               moreInfoLink: "Tell me more"
                           )
                         
                }
                HStack{
                Text("Activity")
                Spacer()
                }.padding()
                HStack{
                        ActivityCard(type: .transfer)
                        ActivityCard(type: .myCard)
                        ActivityCard(type: .insight)
                        }
                .padding()
            }.frame(width: Constant.width,height: Constant.height)
        }
    }
}

#Preview {
    HomeView()
}
