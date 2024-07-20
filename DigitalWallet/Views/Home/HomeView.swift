//
//  HomeView.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Color(hex: "#5AA5E2")
                    .frame(height: Constant.height/3)
                Color.clear
            }
            .edgesIgnoringSafeArea(.all)
            
            if let user = viewModel.user ,  let account=viewModel.account {
                VStack(spacing: 20){
                    HStack(){
                        VStack(alignment:.leading){
                            Text("$\(account.balance)")
                                .font(.system(size: 40, weight: .bold))
                            Text("Available balance")
                                .font(.system(size: 15, weight: .medium))
                        }
                        Spacer()
                        Image(systemName: "person.circle")
                            .font(.system(size: 35))
                    }.padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                    HStack(alignment:.center){
                        ExpenseCard(
                            spentAmount: account.spent,
                            earnedAmount: account.earned,
                            spentDescription: "You spent $\(account.spent) this month",
                            moreInfoLink: "Tell me more"
                        )
                        
                    }
                    HStack{
                        Text("Activity")
                        Spacer()
                    }.padding(.horizontal,15)
                    HStack{
                        ActivityCard(type: .transfer)
                        ActivityCard(type: .myCard)
                        ActivityCard(type: .insight)
                    }
                    Spacer()
                }.frame(width: Constant.width,height: Constant.height)
                
            } else {
                ProgressView()
                Spacer()
            }
            
        }
    }
}

#Preview {
    HomeView()
}
