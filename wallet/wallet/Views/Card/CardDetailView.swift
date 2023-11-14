//
//  CardDetailView.swift
//  wallet
//
//  Created by Edvaldo Martins on 10/11/2023.
//

import SwiftUI

struct CardDetailView: View {
    var card : Card
    var animation: Namespace.ID
    @EnvironmentObject var viewModel: TransactionsViewModel
    
    @Binding var showCard : Bool
    @State var hasScrolled: Bool = false
    @State var hideCard: Bool = false
    @State var showPayment = false
    @State var selectedIndex: Int = 0
    @State var degree = 0.0
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            VStack(spacing: 0) {
               
                BarView(
                    expanded: .constant(false),
                    hidePlusAction: false,
                    onTap: { onTapped() })
                .padding([.horizontal, .top])
               
                Spacer()
                
                GeometryReader { reader in
                    let height = reader.size.height + 50
                    
                    scrollBody
                        .coordinateSpace(name: "scroll")
                        .frame(maxWidth: .infinity)
                        .offset(y: showCard ? 0 : height)
                }
                .zIndex(-10)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
            .safeAreaInset(edge: .bottom, content: {
                Color.clear
                    .frame(height: 0)
                    .background(Color("Background").opacity(0.9))
                    .border( .bar)
            })
            .onAppear {
                withAnimation(.easeInOut.delay(0.35)) {
                    showCard = true
                    degree = 90
                }
            }
            .sheet(isPresented: $showPayment, content: {
                let transaction = viewModel.transactions[selectedIndex]
                TransactionDetailView(
                    transaction: transaction,
                    cardNumber: card.maskNumberCard)
                .presentationDetents([.fraction(transaction.isAcceped ? 0.75 : 0.65)])
                .presentationCornerRadius(32)
                .presentationDragIndicator(.visible)
            })
            
        }
    }
    
    // MARK: Scroll View of Cards
    var scrollBody: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                ZStack {
                    CardView(card: card, hideBalance: $showCard)
                        .matchedGeometryEffect(id: card.id, in: animation)
                        .frame(height: 150)
                        .rotation3DEffect(.degrees(degree), axis: (x:   0, y: 0, z: 1))
                        .animation(.easeInOut(duration: 0.35), value: degree)
                        .offset(x: (degree == 90) ?  -225 : 0, y: 20)
                        .onTapGesture { onTapped() }
                    
                    cardInfoView
                }
                .padding(.top, 10)
                .opacity(hideCard ? 0 : 1)
              
                transactionLabel
                
                ForEach (Array(viewModel.transactions.enumerated()),id: \.offset) { index, payment in
                    VStack {
                        TransactionItemView(payment: payment,index: index)
                        Divider().background(.primary)
                    }
                    .onTapGesture {
                        selectedIndex = index
                        withAnimation {
                            showPayment = true
                        }
                    }
                    
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
    
    // MARK: Label transaction
    var transactionLabel: some View {
        HStack(spacing: 0) {
            Text("Last transactions")
                .font(.title3)
                .fontWeight(.semibold)
            Spacer()
        }
        .padding(.top, 50)
    }
    
    // MARK: Card details
    var cardInfoView: some View {
        VStack(alignment: .leading) {
            Text("Mastercard Debit")
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .padding(.bottom, 0.2)
            
            Text(card.cardNumber)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .padding(.bottom, 30)
            
            Text("BALANCE")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Text(card.formatterBalance)
                .font(.system(size: 28))
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("VALID THRU")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    
                    Text("02/24")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                
                VStack(alignment: .leading) {
                    Text("CVV")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    
                    Text("123")
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 20)
            
            Text("NAME")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Text(card.cardHolderName)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            
            Button {
                
            } label: {
                Text("Freeze Card".uppercased())
                    .font(.caption)
                    .foregroundColor(.primary)
                    .bold()
                    .frame(width: 150, height: 45)
                    .background(Color.clear)
                    .cornerRadius(16)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Border"), lineWidth: 1.2)
            )
            .padding(.top, 30)
           
            
        }
        .padding(.leading, 50)
        .offset(x: -16)
    }
    
    func onTapped () {
        withAnimation(.easeInOut(duration: 0.35)) {
            hideCard = true
            showCard = false
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(.easeInOut(duration: 0.35)) {
                showCard = false
            }
        }
    }
    
}

#Preview {
    @Namespace var animation
    return CardDetailView(
        card: Card.getMock(),
        animation: animation,
        showCard: .constant(true)
    )
    .environmentObject(TransactionsViewModel())
}
