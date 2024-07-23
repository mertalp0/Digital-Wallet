//
//  HomeView.swift
//  DigitalWallet
//
//  Created by mert alp on 18.07.2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject  var viewModel : HomeViewModel
    var body: some View {
        ZStack (alignment: .top){
            
            VStack(spacing: 0) {
                DWColors.primary
                    .frame(height: Constant.height / 3)
            }
            .edgesIgnoringSafeArea(.all)
            
            if let _ = viewModel.user, let account = viewModel.account {
                
                VStack(spacing: 20) {
                   
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            Text("$\(account.balance)")
                                .font(.system(size: 40, weight: .bold))
                            Text(LocalizedStrings.Home.availableBalance)
                                .font(.system(size: 15, weight: .medium))
                        }
                        Spacer()
                        Image(systemName: "person.circle")
                            .font(.system(size: 35))
                    }
                    .padding(EdgeInsets(top: 15, leading: 50, bottom: 15, trailing: 50))
                    HStack(alignment: .center) {
                        ExpenseCard(
                            spentAmount: account.spent,
                            earnedAmount: account.earned,
                            spentDescription: String(format: LocalizedStrings.Home.spentDescription, account.spent)
                        )
                    }
                    
                    HStack {
                        Text(LocalizedStrings.Home.activityTitle)
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    
                    HStack {
                        ActivityCard(type: .transfer, action: { viewModel.onTapTransferView()})
                        ActivityCard(type: .myCard, action:{})
                        ActivityCard(type: .insight, action:{})
                    }
                    Spacer()
                }
                .frame(width: Constant.width, height: Constant.height)
                
            } else {
                ProgressView()
                Spacer()
            }
        }.onAppear {
            viewModel.fetchUser()
        }
    }
}

