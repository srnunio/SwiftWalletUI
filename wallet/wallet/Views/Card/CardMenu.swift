//
//  CardMenu.swift
//  wallet
//
//  Created by Edvaldo Martins on 08/11/2023.
//

import SwiftUI

struct CardMenu: View {
    let size: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "lock")
                .font(.system(size: 30.0))
                .foregroundColor(.white)
                .frame(width: size,height: size)
            
            Image(systemName: "pencil.and.ellipsis.rectangle")
                .font(.system(size: 30.0))
                .foregroundColor(.white)
                .frame(width: size,height: size)
            
            Image(systemName: "slider.horizontal.3")
                .font(.system(size: 30.0))
                .foregroundColor(.white)
                .frame(width: size,height: size)
        }
        .background(Color(#colorLiteral(red: 0.1803921569, green: 0.2, blue: 0.2352941176, alpha: 1)))
        .cornerRadius(8)
    }
}

#Preview {
    CardMenu(size: 66)
}
