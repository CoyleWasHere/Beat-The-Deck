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
    @State private var backAlert = false
    @State private var showDeal = true
    @State private var restartAlert = false
    
    
    var deck = ["card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "card11", "card12", "card13", "card14"]
    @State var gameCards:[String] = []
    @State var cardCount = 0
    @State var gameNumber = 0
    @State var newNumber = 0
    
    
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
                            if gameCards[index] != "card1" {
                                Button {
                                    
                                    if let gameNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        print(gameNumber)
                                        self.gameNumber = gameNumber
                                    }
                                    
                                    print("Higher")
                                    
                                    gameCards.insert(deck[newCard], at: index)
                                    
                                    gameCards.remove(at: index)
                                    
                                    gameCards[index] = deck[newCard]
                                    
                                    if let newNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        print(newNumber)
                                        self.newNumber = newNumber
                                    }
                                    
                                    if gameNumber < newNumber {
                                        print("Winner")
                                        totalCards -= 1
                                    } else {
                                        print("Loser")
                                        gameCards[index] = "card1"
                                    }
                                    
                                    
                                } label: {
                                    Text("Higher")
                                }
                                Button {
                                    
                                    if let gameNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        print(gameNumber)
                                        self.gameNumber = gameNumber
                                    }
                                    
                                    print("Lower")
                                    
                                    gameCards.insert(deck[newCard], at: index)
                                    
                                    gameCards.remove(at: index)
                                    
                                    gameCards[index] = deck[newCard]
                                    
                                    if let newNumber = Int(gameCards[index].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) {
                                        // Do something with this number
                                        print(newNumber)
                                        self.newNumber = newNumber
                                    }
                                    
                                    if gameNumber > newNumber {
                                        print("Winner")
                                        totalCards -= 1
                                    } else {
                                        print("Loser")
                                        gameCards[index] = "card1"
                                    }
                                    
                                    
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
            }
            
            Spacer()
            
            Text("Cards Remaining: \(totalCards)")
                .foregroundStyle(.white)
                .font(.title)
            
            // Deal Cards
            if showDeal == true {
                Button {
                    withAnimation {
                        dealCards()
                        showDeal = false
                        totalCards -= 9
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
            cardCount += 1
        } while cardCount < 9
        print(gameCards)
        cardCount = 0
    }
    
}

#Preview {
    PlayView()
}
