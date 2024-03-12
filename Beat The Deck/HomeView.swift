//
//  HomeView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Beat The Deck")
            
            Button {
                // TODO: Navigate to PlayView
                PlayView()
            } label: {
                Text("Start")
            }
            
            Button {
                // TODO: Pop up modal view of InformationView
                InformationView()
            } label: {
                Text("How To Play")
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
