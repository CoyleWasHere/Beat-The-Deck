//
//  InformationView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI

struct InformationView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack{
            ZStack{
                Text("How To Play")
                    .font(.title)
                    .underline()
                HStack{
                    Spacer()
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.black)
                    }
                }
            }
            VStack(alignment: .leading){
                Text(" - Tap a Card, then you will be given three options.")
                Text(" - (Higher, Lower, Cancel)")
                Text(" - If the next card drawn matches your guess that card goes on top of the selected pile and you continue")
                Text(" - If the next card drawn does not match your guess the pile gets turned over and you can no longer use that pile")
                Text(" - In the case where the drawn card is the same number as the pile, that pile gets turned over and you no longer get to use it.")
                Text(" - If you choose a pile and no longer want to use that one, select cancel to take you back to the selection.")
            }
            
            Spacer()
            Text("How To Win")
                .font(.title)
                .underline()
            VStack(alignment: .leading) {
                Text(" - In order to win you must go through an entire deck of 52 cards before all the piles are turned over.")
                Text(" - If all the decks are turned over it is GAME OVER and you must restart.")
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    InformationView()
}
