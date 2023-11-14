//
//  ContentView.swift
//  wallet
//
//  Created by Edvaldo Martins on 08/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HomeView()
                .environmentObject(HomeViewModel())
        }
        .background(Color("Background"))
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 44)
        }
        .dynamicTypeSize(.large ... .xxLarge)
        
    }
}

#Preview {
    ContentView()
}
