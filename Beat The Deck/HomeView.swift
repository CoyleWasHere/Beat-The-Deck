//
//  HomeView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI

struct HomeView: View {
    
    @State var showSheet = false
    
    var body: some View {
        
        // TODO: Adjust Fonts and Sizing of the words, else it is complete!
        
        NavigationStack{
            VStack {
                Text("Beat The Deck")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                NavigationLink {
                    PlayView()
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 250, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 110))
                            .foregroundStyle(Color(red: 12/255, green: 234/255, blue: 17/255))
                        Text("Start")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom, 25)
                
                Button {
                    showSheet = true
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 250, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 110))
                            .foregroundStyle(Color(red: 255/255, green: 165/255, blue: 0/255))
                        Text("How to Play")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.top, 25)
                Spacer()
            }
            .padding()
            .background(Image("background-cloth"))
            .sheet(isPresented: $showSheet, content: {
                InformationView()
                    .presentationDetents([.fraction(0.90)])
            })
        }
    }
}

#Preview {
    HomeView()
}
