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
    @State var cards = ["card2", "card3", "card4", "card5", "card8", "card10", "card11", "card13", "card14"]
    @State var flipCard = 0
    
    @State private var backAlert = false
    
    var body: some View {
        VStack{
            ZStack{
                Text("Beat The Deck")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
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
                            dismiss()
                        }label: {
                            Text("Continue Playing")
                        }
                    }
                    Spacer()
                }
                .padding()
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
            
            // TODO: Deal Cards and create game functionality
            //            Button {
            //            } label: {
            //                ZStack{
            //                    Rectangle()
            //                        .frame(width: 250, height: 110)
            //                        .clipShape(RoundedRectangle(cornerRadius: 110))
            //                        .foregroundStyle(Color(red: 255/255, green: 165/255, blue: 0/255))
            //                    Text("Deal Cards")
            //                        .foregroundStyle(.white)
            //                        .font(.title)
            //                        .fontWeight(.semibold)
            //                }
            //            }
            
            LazyVGrid(columns: [GridItem(spacing:20), GridItem(spacing:20), GridItem(spacing:20)], spacing: 20, content: {
                
                // Select 9 cards from the array and place them in the grid
                ForEach(Array(cards.enumerated()), id:\.element) { index, card in
                    
                    var faceCard = Int.random(in: 2...14)
                    let drawnCard = Int.random(in: 2...14)
                    
                    if flipCard != 1 {
                        Menu{
                            Button{
                                // Draw Card
                                // If card is higher leave new card on top of deck
                                if faceCard < drawnCard {
                                    // Decrement Cards remaining
                                    totalCards -= 1
                                    print("The Next Card Was Higher \(drawnCard)")
                                    print(card)
                                    print(index)
                                } else {
                                    // If card is equal or lower flip deck over to back of card
                                    flipCard = 1
                                    print("The Next Card Was Lower or Equal \(drawnCard)")
                                    print(card)
                                    print(index)
                                }
                                
                                // Check if cards remaining is 0
                                if totalCards == 0 {
                                    // DISPLAY WIN SCREEN
                                }
                            }label: {
                                Text("Higher")
                            }
                            Button{
                                // Draw Card
                                // If card is lower leave new card on top of deck
                                if faceCard > drawnCard {
                                    faceCard = drawnCard
                                    // Decrement Cards remaining
                                    totalCards -= 1
                                    print("The Next Card Was Lower \(drawnCard)")
                                } else {
                                    // If card is equal or lower flip deck over to back of card
                                    flipCard = 1
                                    print("The Next Card Was Higher or Equal \(drawnCard)")
                                }
                                
                                // Check if cards remaining is 0
                                if totalCards == 0 {
                                    // DISPLAY WIN SCREEN
                                }
                            }label: {
                                Text("Lower")
                            }
                            Button{
                                print("Choice Cancelled")
                            }label: {
                                Text("Cancel")
                            }
                        } label: {
                            Image("card\(faceCard)")
                                .resizable()
                                .frame(width: 100, height: 156)
                        }

                    } else {
                        Image("card\(1)")
                            .resizable()
                            .frame(width: 100, height: 156)
                    }
                }
                
                // Add the functionality to each card
//                Group{
//                    Image("card3")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                    Image("card4")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                    Image("card5")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                    Image("card6")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                    Image("card7")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                    Image("card8")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                    Image("card9")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                    Image("card10")
//                        .resizable()
//                        .frame(width: 100, height: 156)
//                }
            })
            .padding()
            Spacer()
            
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
