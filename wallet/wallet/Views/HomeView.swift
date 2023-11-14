//
//  HomeView.swift
//  wallet
//
//  Created by Edvaldo Martins on 12/11/2023.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Namespace var animation
    
    var body: some View {
        let expanded = viewModel.expanded
        let cards = viewModel.cards
        
        ZStack {
            Color("Background").ignoresSafeArea()
            VStack(spacing: 0) {
                BarView(expanded: $viewModel.expanded, onTap: {
                    onExpanded(false)
                })
                
                ScrollInfoView(cards: cards, expanded: expanded)
            }
            .padding([.horizontal, .top])
            .overlay (content: {
                if let card = viewModel.currentCard, viewModel.showDetailCard {
                    CardDetailView(
                        card: card,
                        animation: animation, showCard: $viewModel.showDetailCard)
                    .environmentObject(TransactionsViewModel())
                }
            })
        }
        .onChange(of: viewModel.showDetailCard){ _, value in
            if !value && viewModel.currentCard != nil {
               onTapped(card: nil)
            }
        }
    }
    
    // MARK: Scrool and list of cards
    @ViewBuilder
    func ScrollInfoView (cards: [Card], expanded: Bool) -> some View {
          ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                ForEach (cards) { card in
                    let selected = viewModel.currentCard?.id == card.id
                    let degree: Double = selected ? 90 : 0
                    Group {
                        CardUIView(card: card, opened: expanded)
                            .matchedGeometryEffect(id: card.id, in: animation)
                            .rotation3DEffect(.degrees(degree), axis: (x:   0, y: 0, z: 1))
                            .animation(.easeInOut(duration: 0.35), value: degree)
                            .offset(x: (degree == 90) ?  -225 : 0, y: 40)
                    }
                    .onTapGesture {
                        if expanded {
                            onTapped(card: card)
                        } else {
                            onExpanded(true)
                        }
                    }
                }
            }
            .overlay {
                Rectangle()
                    .fill(Color.clear)
                    .onTapGesture { onExpanded(true) }
            }
        }
        .coordinateSpace(name: "SCROLL")
        .offset(y: expanded ? 0 : 30)
       
    }
    
    // MARK: build card ui
    @ViewBuilder
    func CardUIView (card: Card, opened: Bool) -> some View {
        let index = viewModel.getIndex(card: card)
        let expanded =  viewModel.expanded
        GeometryReader { reader in
            let rect = reader.frame(in: .named("SCROLL"))
            let offeset =  CGFloat(index * (expanded ? 10 : 70))
            CardView(card: card, hideBalance: .constant(false))
                .offset(y: viewModel.expanded ? offeset : -rect.minY  +  offeset)
        }
        .frame(width: .infinity ,height: 200)
    }
    
    // MARK: select and open card details
    func onTapped(card: Card?) {
        withAnimation(.easeInOut(duration: 0.35)){
            viewModel.showDetailCard = card != nil
            viewModel.setCurrentCard(card)
        }
    }
    
    // MARK: expanded or shrink list of card
    func onExpanded (_ value: Bool) {
        withAnimation(.interactiveSpring(
            response:0.8,
            dampingFraction: 0.7,
            blendDuration: 0.7)) {
                viewModel.expanded = value
            }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
