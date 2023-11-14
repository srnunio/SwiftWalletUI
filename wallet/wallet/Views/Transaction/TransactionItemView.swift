//
//  PaymentItemView.swift
//  wallet
//
//  Created by Edvaldo Martins on 10/11/2023.
//

import SwiftUI

struct TransactionItemView: View {
    var payment: Transaction
    var index : Int
    @State var showCard: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(payment.service.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 10,style: .continuous))
                .padding(.horizontal, 2)
            
            VStack (alignment: .leading, spacing: 8){
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(payment.reference.uppercased())
                        Text(payment.formattedDate)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(payment.formatterAmount)
                }
            } 
        }
        .opacity(showCard ? 1 : 0)
        .padding(.vertical,8)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeInOut(duration: 0.3).delay(Double(index) * 0.1)) {
                    showCard = true
                }
            }
        }
    }
}

#Preview { 
    return TransactionItemView(payment: Transaction.getMock(),index: 0)
}
