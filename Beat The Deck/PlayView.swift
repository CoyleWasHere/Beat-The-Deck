//
//  PlayView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI

struct PlayView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var totalCards = 52
    @State var showSheet = false
    @State var cards = ["card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "card11", "card12", "card13", "card14"]
    
    var body: some View {
        VStack{
            ZStack{
                Text("Beat The Deck")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                HStack{
                    Button{
                        // Display InformationView Modally
                        dismiss()
                    }label: {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    Spacer()
                }
                .padding()
                HStack{
                    Spacer()
                    Button{
                        // Display InformationView Modally
                        showSheet = true
                    }label: {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                }
                .padding()
            }
            
            Spacer()
            
            // TODO: Deal Cards and create game functionality
//            Button {
//            } label: {
//                ZStack{
//                    Rectangle()
//                        .frame(width: 250, height: 110)
//                        .clipShape(RoundedRectangle(cornerRadius: 110))
//                        .foregroundStyle(Color(red: 255/255, green: 165/255, blue: 0/255))
//                    Text("Deal Cards")
//                        .foregroundStyle(.white)
//                        .font(.title)
//                        .fontWeight(.semibold)
//                }
//            }
            
            LazyVGrid(columns: [GridItem(spacing:20), GridItem(spacing:20), GridItem(spacing:20)], content: {
                
            })
            
            // TODO: Use for loop to place 9 random cards from cards array onto the canvas
            //            for cards in 1..<8 {
            //                print(cards)
            //            }
            
            Text("Cards Remaining: \(totalCards)")
                .foregroundStyle(.white)
        }
        .background(Image("background-cloth"))
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showSheet, content: {
            InformationView()
                .presentationDetents([.fraction(0.90)])
        })
    }
}

#Preview {
    PlayView()
}
