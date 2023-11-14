////
////  Home.swift
////  wallet
////
////  Created by Edvaldo Martins on 08/11/2023.
////
//
//import SwiftUI
//
//struct Home: View {
//    @EnvironmentObject  var viewModel: CardsViewModel
//    
//    
//    var body: some View {
//        VStack {
//            Text("🌈 Cards Effects 🌈")
//                .foregroundColor(.white)
//                .font(.title)
//                .bold()
//            Spacer()
//            CardList(cards: $viewModel.cards)
//                .frame(height: 220)
//                .padding(.horizontal,15)
//        }
//        .padding(.vertical)
//        .preferredColorScheme(.dark)
//        .onAppear(perform: viewModel.fetchCards)
//    }
//    
//}
//
//#Preview {
//    Home()
//        .environmentObject(CardsViewModel())
//}
//
// 
