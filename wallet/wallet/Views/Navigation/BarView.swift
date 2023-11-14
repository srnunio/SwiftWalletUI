//
//  BarView.swift
//  wallet
//
//  Created by Edvaldo Martins on 14/11/2023.
//

import SwiftUI

struct BarView: View {
    @Binding var expanded: Bool
    var hidePlusAction: Bool = true
    var onTap: () -> Void
    
    var body: some View {
        let date = Date()
        let weekDay = date.formatted(.dateTime.weekday(.wide))
        let day = date.formatted(.dateTime.day())
        let month = date.formatted(.dateTime.month())
        HStack(alignment: .center,spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Hi, Edivaldo")
                    .font(.system(size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Text("\(weekDay), \(day) \(month)")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            if !expanded && hidePlusAction {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color("Placeholder"), in: Circle())
                }
                .padding(.horizontal, 10)
            }
            
            Button {
                
            } label: {
                Image(systemName: "bell")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Placeholder"), in: Circle())
            }
            .padding(.horizontal, expanded ? 40 : 0)
        }
        .overlay(alignment: .trailing) {
            Button {
               
                withAnimation(.interactiveSpring(
                    response:0.8,
                    dampingFraction: 0.7,
                    blendDuration: 0.7)) {
                        onTap() 
                    }
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Placeholder"), in: Circle())
            }
            .rotationEffect(.init(degrees: expanded ? 45 : 0))
            .offset(x: expanded ? 10 : 15)
            .opacity(expanded ? 1 : 0)
            .padding(.horizontal, expanded ? 8 : 0)
        }
        .padding(.bottom, 0)
    }
}

#Preview {
    BarView(
        expanded: .constant(true),
        hidePlusAction: false,
        onTap: {})
}
