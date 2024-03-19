//
//  PlayView.swift
//  Beat The Deck
//
//  Created by Daniel Coyle on 3/12/24.
//

import SwiftUI
import AVFoundation

struct PlayView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var audioPlayer:AVAudioPlayer?
    
    @State var totalCards = 12
    @State var showSheet = false
    @State private var backAlert = false
    @State private var showDeal = true
    @State private var restartAlert = false
    
    @State var deck = ["clubs_2", "clubs_3", "clubs_4", "clubs_5", "clubs_6", "clubs_7", "clubs_8", "clubs_9", "clubs_10", "clubs_11", "clubs_12", "clubs_13", "clubs_14", "diamonds_2", "diamonds_3", "diamonds_4", "diamonds_5", "diamonds_6", "diamonds_7", "diamonds_8", "diamonds_9", "diamonds_10", "diamonds_11", "diamonds_12", "diamonds_13", "diamonds_14", "hearts_2", "hearts_3", "hearts_4", "hearts_5", "hearts_6", "hearts_7", "hearts_8", "hearts_9", "hearts_10", "hearts_11", "hearts_12", "hearts_13", "hearts_14", "spades_2", "spades_3", "spades_4", "spades_5", "spades_6", "spades_7", "spades_8", "spades_9", "spades_10", "spades_11", "spades_12", "spades_13", "spades_14", "spades_14"]
    
    @State var gameCards:[String] = []
    @State var cardCount = 0
    @State var gameNumber = 0
    @State var newNumber = 0
    @State var cardSelection = "ON"
    
    var body: some View {
        
        let newCard = Int.random(in: 0..<deck.count)
        
        VStack{
            
            // Title
            ZStack{
                Text("Beat The Deck")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                
                // Back Button
                HStack{
                    Button{
                        // Go Back One Page
                        backAlert = true
                    }label: {
                        Image(systemName: "arrowshape.backward.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.black)
                    }
                    .alert("Are you sure you want to go back?", isPresented: $backAlert) {
                        Button{
                            dismiss()
                        }label: {
                            Text("Go Back")
                        }
                        Button{
                            
                        }label: {
                            Text("Continue Playing")
                        }
                    }
                    Spacer()
                }
                .padding()
                
                // How to Play
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
            
            // Display the cards in a Grid
            LazyVGrid(columns: [GridItem(spacing:20), GridItem(spacing:20), GridItem(spacing:20)], spacing: 20, content: {
                
                // Select 9 cards from the array and place them in the grid
                ForEach(gameCards.indices, id: \.self) { index in
                    
                    if totalCards != 0 {
                        Menu {
                            if gameCards[index] == "back" {
                                Button {
                                    gameCards[index] = "back"
                                } label: {
                                    Text("Choose Another Card")
                                }
                                
                            }else {
                                Button {
                                    
                                    flipCard()
                                    audioPlayer?.play()
                                    
                                    if let gameNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        // print(gameNumber)
                                        self.gameNumber = gameNumber
                                    }
                                    
                                    // print("Higher")
                                    
                                    gameCards.insert(deck[newCard], at: index)
                                    
                                    gameCards.remove(at: index)
                                    
                                    gameCards[index] = deck[newCard]
                                    
                                    if let newNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        // print(newNumber)
                                        self.newNumber = newNumber
                                    }
                                    
                                    if gameNumber < newNumber {
                                        // print("Winner")
                                    } else {
                                        // print("Loser")
                                        gameCards[index] = deck[newCard]
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                            gameCards[index] = "back"
                                        }
                                    }
                                    totalCards -= 1
                                    // print(deck[newCard])
                                    deck.remove(at: newCard)
                                    
                                } label: {
                                    Text("Higher")
                                }
                                Button {
                                    
                                    flipCard()
                                    audioPlayer?.play()
                                    
                                    if let gameNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        // print(gameNumber)
                                        self.gameNumber = gameNumber
                                    }
                                    
                                    // print("Lower")
                                    
                                    gameCards.insert(deck[newCard], at: index)
                                    
                                    gameCards.remove(at: index)
                                    
                                    gameCards[index] = deck[newCard]
                                    
                                    if let newNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        // print(newNumber)
                                        self.newNumber = newNumber
                                    }
                                    
                                    if gameNumber > newNumber {
                                        // print("Winner")
                                    } else {
                                        // print("Loser")
                                        gameCards[index] = deck[newCard]
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                            gameCards[index] = "back"
                                        }
                                    }
                                    totalCards -= 1
                                    // print(deck[newCard])
                                    deck.remove(at: newCard)
                                    
                                } label: {
                                    Text("Lower")
                                }
                                Button{
                                    
                                } label: {
                                    Text("Cancel")
                                }
                            }
                        } label: {
                            Image(gameCards[index])
                                .resizable()
                                .frame(width: 100, height: 156)
                        }
                    }
                }
            })
            .padding()
            
            // If you win, show a winning message!!
            if totalCards <= 0 {
                ZStack{
                    Rectangle()
                        .frame(width: 400, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 110))
                        .foregroundStyle(Color(red: 12/255, green: 234/255, blue: 17/255))
                    Text("Congratulations . . . You Win")
                        .foregroundStyle(.white)
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .onAppear(perform: {
                    winner()
                    audioPlayer?.play()
                })
            }
            
            Spacer()
            
            Text("Cards Remaining: \(totalCards)")
                .foregroundStyle(.white)
                .font(.title)
            
            // Deal Cards
            if showDeal == true {
                Button {
                    withAnimation {
                        gameCards = []
                        dealCards()
                        showDeal = false
                        totalCards -= 9
                        audioPlayer?.play()
                    }
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 250, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 110))
                            .foregroundStyle(Color(red: 12/255, green: 234/255, blue: 17/255))
                        Text("Deal")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
            }
            
            // Restart Game
            if showDeal == false {
                Button{
                    restartAlert = true
                } label: {
                    ZStack{
                        Rectangle()
                            .frame(width: 250, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 110))
                            .foregroundStyle(Color(red: 255/255, green: 165/255, blue: 0/255))
                        Text("Restart")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                }
                .alert("Are you sure you want to restart?", isPresented: $restartAlert) {
                    Button {
                        withAnimation {
                            deck = ["clubs_2", "clubs_3", "clubs_4", "clubs_5", "clubs_6", "clubs_7", "clubs_8", "clubs_9", "clubs_10", "clubs_11", "clubs_12", "clubs_13", "clubs_14", "diamonds_2", "diamonds_3", "diamonds_4", "diamonds_5", "diamonds_6", "diamonds_7", "diamonds_8", "diamonds_9", "diamonds_10", "diamonds_11", "diamonds_12", "diamonds_13", "diamonds_14", "hearts_2", "hearts_3", "hearts_4", "hearts_5", "hearts_6", "hearts_7", "hearts_8", "hearts_9", "hearts_10", "hearts_11", "hearts_12", "hearts_13", "hearts_14", "spades_2", "spades_3", "spades_4", "spades_5", "spades_6", "spades_7", "spades_8", "spades_9", "spades_10", "spades_11", "spades_12", "spades_13", "spades_14", "spades_14"]
                            gameCards = []
                            showDeal = true
                            totalCards = 52
                        }
                    } label: {
                        Text("Restart")
                    }
                    Button {
                    } label: {
                        Text("Continue Playing")
                    }
                    
                }
            }
        }
        .background(Image("background-cloth"))
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showSheet, content: {
            InformationView()
                .presentationDetents([.fraction(0.90)])
        })
    }
    
    // Get a random array of nine cards
    func dealCards() {
        repeat {
            let randomCard = Int.random(in: 0..<deck.count)
            gameCards.append(deck[randomCard])
            deck.remove(at: randomCard)
            cardCount += 1
        } while cardCount < 9
        // print(gameCards)
        // print(deck)
        cardCount = 0
        
        // Load the audio file
        if let soundURL = Bundle.main.url(forResource: "dealCards", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = 0 // Play infinitely
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found")
        }
        
        
    }
    
    func flipCard() {
        // Load the audio file
        if let soundURL = Bundle.main.url(forResource: "flipCard", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = 0 // Play infinitely
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found")
        }
    }
    
    func winner() {
        // Load the audio file
        if let soundURL = Bundle.main.url(forResource: "Win", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
                audioPlayer?.numberOfLoops = 0 // Play infinitely
            } catch {
                print("Error loading sound file: \(error.localizedDescription)")
            }
        } else {
            print("Sound file not found")
        }
    }
    
    
}

#Preview {
    PlayView()
}
