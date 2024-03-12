//
//  PlayView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI

struct PlayView: View {
    
    @State var totalCards = 52
    @State var showSheet = false
    
    var body: some View {
        VStack{
            ZStack{
                Text("Beat The Deck")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                HStack{
                    Spacer()
                    Button{
                        // TODO: Display InformationView Modally
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
