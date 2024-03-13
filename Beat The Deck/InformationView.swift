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
