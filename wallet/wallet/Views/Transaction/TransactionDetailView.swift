//
//  PaymentDetailView.swift
//  wallet
//
//  Created by Edvaldo Martins on 13/11/2023.
//

import SwiftUI

struct TransactionDetailView: View {
    var transaction: Transaction
    var cardNumber: String
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
//                Text("Transaction Details")
//                    .font(.system(size: 24))
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .overlay(alignment: .trailing) {
//                        Button {
//                            dismiss()
//                        } label: {
//                            Image(systemName: "plus")
//                                .foregroundColor(.white)
//                                .padding(10)
//                                .background(Color("Placeholder"), in: Circle())
//                        }
//                        .rotationEffect(.init(degrees:  45 ))
//                        .offset(x: -16)
//                        .opacity(1)
//                    }
//                    .ignoresSafeArea()
//                    .padding(.horizontal, 0)
//                    .padding(.top, 130) 
                
                Image(transaction.service.lowercased())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                    .padding(.horizontal, 2)
                    .padding(.vertical, 20)
                
                infos
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.clear)
                            .stroke(Color("Border"),lineWidth: 0.5)
                    )
                    .padding(.horizontal, 30)
                
                if transaction.isAcceped {
                    Button {
                        dismiss()
                    } label: {
                        Text("refund".uppercased())
                            .font(.subheadline)
                            .foregroundColor(.accentColor)
                            .bold()
                            .frame(width: 170, height: 55)
                            .background(Color("Placeholder").cornerRadius(16))
                    }
                    .padding()  
                    .padding(.bottom, 25)
                }
                Spacer()
                
            }
            .background(Color("Background"))
            .ignoresSafeArea()
        }
    }
    
    var infos: some View {
        VStack(spacing: 0) {
            ValueTile(
                label: "Reference",
                value: transaction.reference)
            .padding(.vertical, 10)
            
            Divider()
            
            ValueTile(
                label: "Amount",
                value: transaction.formatterAmount)
            .padding(.vertical, 10)
            
            Divider()
            
            ValueTile(
                label: "Card",
                value: cardNumber)
            .padding(.vertical, 10)
            
            Divider()
            
            ValueTile(
                label: "Description",
                value: transaction.description)
            .padding(.vertical, 10)
            
            Divider()
           
            ValueTile(
                label: "Date",
                value: transaction.formattedDate)
            .padding(.vertical, 10)
            
            Divider()
           
            ValueTile(
                label: "Status",
                value: transaction.status.rawValue.capitalized,
                colorValue: getColor())
            .padding(.vertical, 10)
            
        }
    }
    
    @ViewBuilder
    func ValueTile (label: String, value: String, colorValue: Color = .secondary) -> some View {
        HStack(alignment: .center,spacing: 0) {
            Text("\(label):")
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Spacer()
            Text(value)
                .foregroundColor(colorValue)
        }
    }
    
    func getColor() -> Color {
        switch transaction.status {
        case .pending:
            return .yellow
        case .accepted:
            return .green
        case .rejected:
            return .red
        }
    }
}

#Preview { 
    return TransactionDetailView(transaction: Transaction.getMock(), cardNumber: "6443 9090 9393 8383")
}
