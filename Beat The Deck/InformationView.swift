//
//  InformationView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack{
            Text("How To Play")
                .font(.title)
                .underline()
            Text("Information with bullet points")
            Spacer()
            Text("How To Win")
                .font(.title)
                .underline()
            Text("Information with bullet points")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    InformationView()
}
