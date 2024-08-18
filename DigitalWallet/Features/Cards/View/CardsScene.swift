//
//  MyCardView.swift
//  DigitalWallet
//
//  Created by mert alp on 28.07.2024.
//
import SwiftUI

struct CardsScene: View {
    @ObservedObject var viewModel: CardsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var selectedCardIndex = 0

    var body: some View {
        VStack {
            HStack {
                ZStack {
                    HStack {
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.title)
                                .foregroundColor(.black)
                                .padding(.leading, 10)
                        }
                        Spacer()
                    }
                    Text("Cards")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
            if viewModel.cards.isEmpty {
                VStack {
                    Spacer()
                    Text("No Card")
                    Spacer()
                }
            }
            else {
                VStack {
                    TabView(selection: $selectedCardIndex) {
                        ForEach(viewModel.cards.indices, id: \.self) { index in
                            CustomCard(card: viewModel.cards[index])
                                .tag(index)
                                .onAppear {
                                    viewModel.selectedCardIndex = index
                                }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 250)

                    PageControl(numberOfPages: viewModel.cards.count, currentPage: $selectedCardIndex)
                    TransactionView(transactions: viewModel.cards[selectedCardIndex].transactions)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    CardsScene(viewModel: CardsViewModel())
}

