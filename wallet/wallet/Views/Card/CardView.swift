//
//  CardView.swift
//  wallet
//
//  Created by Edvaldo Martins on 08/11/2023.
//

import SwiftUI

struct CardView: View {
    var card : Card
    
    @Binding var hideBalance: Bool
    
    var center = UnitPoint(x: 0.3, y: 0.2)
    
    var body: some View { 
        VStack {
            ZStack(alignment: .top) {
                card.getColor.cornerRadius(16)
                content.padding(18)
                
                if hideBalance {
                    HStack {
                        card.getLogo
                            .resizable()
                            .frame(width: 60, height: 38,alignment: .leading)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 18)
                        Spacer()
                        Image("chips")
                            .padding(.horizontal, 18)
                    }
                }
                
                if !hideBalance {
                    logoBody.padding(18)
                }
            }
            .background(.ultraThinMaterial, in:
                            RoundedRectangle(cornerRadius: 16, style: .continuous))
            .frame(height: 200)
            .frame(maxWidth: .infinity)
        }
    }
    
    // MARK: Logo of provider card
    var logoBody: some View {
        VStack {
            HStack {
                Spacer()
                card.getLogo
            }
            Spacer()
        }
    }
    
    // MARK: Card details
    var content: some View {
        let font = "Courier"
        return HStack {
            VStack(alignment: .leading) {
                
                if !hideBalance{
                    Text("balance".uppercased())
                        .foregroundColor(.white)
                        .font(.caption)
                        .fontWeight(.medium)
                    
                    Text(card.formatterBalance)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.custom(font, size: 28))
                }
                
                Spacer()
                
                Image("chips")
                
                Text(card.maskNumberCard)
                    .foregroundColor(.white)
                    .font(.custom(font, size: 22))
                    .fontWeight(.bold)
                
                Text(card.cardHolderName)
                    .foregroundColor(.white)
                    .font(.custom(font,size: 14))
            }
            Spacer()
        } 
    }
}

#Preview {
    return CardView(card:  Card.getMock(), hideBalance: .constant(true))
        .padding(32)
}
