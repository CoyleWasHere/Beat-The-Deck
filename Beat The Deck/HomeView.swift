//
//  HomeView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    
    @State var showSheet = false
    @State var audioPlayer:AVAudioPlayer?
    
    var body: some View {
        
        NavigationStack{
            VStack {
                Text("Beat The Deck")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Spacer()
                
                NavigationLink {
                    PlayView()
                        .onAppear(perform: {
                            audioPlayer?.pause()
                        })
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
            .onAppear(perform: {
                playMusic()
                audioPlayer?.play()
            })
        }
                
    }
    
    func playMusic() {
        // Load the audio file
         if let soundURL = Bundle.main.url(forResource: "TheFatRat_Unity", withExtension: "mp3") {
             do {
                 audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                 audioPlayer?.prepareToPlay()
                 audioPlayer?.numberOfLoops = -1 // Play infinitely
             } catch {
                 print("Error loading sound file: \(error.localizedDescription)")
             }
         } else {
             print("Sound file not found")
         }
    }
    
}

#Preview {
    HomeView()
}
