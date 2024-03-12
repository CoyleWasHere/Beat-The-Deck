//
//  PlayView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI

struct PlayView: View {
    
    @State var totalCards = 52
    
    var body: some View {
        VStack{
            
            Button{
                // TODO: Display InformationView Modally
                InformationView()
            }label: {
                Image(systemName: "info.circle.fill")
            }
            Text("Beat The Deck")
            
            // TODO: Use for loop to place 9 random cards from cards array onto the canvas
//            for cards in 1..<8 {
//                print(cards)
//            }
            
            Text("Cards Remaining: \(totalCards)")
        }
    }
}

#Preview {
    PlayView()
}
