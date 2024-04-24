//
//  GameplayView.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 23/04/24.
//

import SwiftUI

struct GameplayView: View {
    @State private var animateViewsIn = false
    var body: some View {
        GeometryReader{ geo in
            ZStack{
                Image("hogwarts")
                    .resizable()
                    .frame(width: geo.size.width * 3 , height: geo.size.height * 1.05)
                    .overlay{
                        Rectangle()
                            .foregroundStyle(.black.opacity(0.8))
                    }
                 VStack{
                    HStack{
                        Button("End Game"){
                            // MARK: Controls
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        Text("Score : 33")
                    }
                    .padding()
                    .padding(.vertical,30)
                    // MARK: Question
                    VStack{
                        if animateViewsIn {
                            Text("Who is Harry Potter?")
                                .transition(.scale)
                                .font(.custom(Constants.hpFont, size: 50))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    }
                    .animation(.easeInOut(duration: 2),value: animateViewsIn)
                    Spacer()
                     //MARK: Hints
                    HStack{
                        VStack{
                            if animateViewsIn {
                                Image(systemName: "questionmark.app.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundStyle(.cyan)
                                    .rotationEffect(.degrees(-15))
                                    .padding()
                                    .padding(.trailing,20)
                                    .transition(.offset(x:-geo.size.width/2))
                            }
                        }
                        .animation(.easeOut(duration: 1.5).delay(2),value:animateViewsIn)
                        
                        VStack{
                            if animateViewsIn {
                        Image(systemName: "book.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundStyle(.black)
                            .frame(width: 100,height: 100)
                            .background(.cyan)
                            .clipShape(.rect(cornerRadius: 20))
                            .rotationEffect(.degrees(15))
                            .padding()
                            .padding(.leading,20)
                            .transition(.offset(x:geo.size.width/2))
                            }
                        }
                        .animation(.easeOut(duration: 1.5).delay(2),value:animateViewsIn)
                    }
                    .padding(.bottom)
                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(),GridItem()]){
                        ForEach(1..<5){ i in
                            VStack{
                                if animateViewsIn {
                                    Text("Answer \(i)")
                                        .minimumScaleFactor(0.5)
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .frame(width: geo.size.width/2.15, height: 80)
                                        .background(.green.opacity(0.5))
                                    .clipShape(.rect(cornerRadius: 25))
                                    .transition(.scale)
                                }
                            }
                            .animation(.easeOut(duration: 1).delay(1.5), value: animateViewsIn)
                            
                        }
                    }
                    Spacer()
                }
                .onAppear{
//                    animateViewsIn = true
                }
                .foregroundStyle(.white)
                .frame(width: geo.size.width, height: geo.size.height)
                //MARK: Celebration
                VStack{
                    Spacer()
                    Text("5")
                        .font(.largeTitle)
                        .padding(.bottom)

                    Text("Brilliant!")
                        .font(.custom(Constants.hpFont, size: 100))
                    Spacer()
                    Text("Answer 1")
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .padding()
                        .frame(width: geo.size.width/2.15, height: 80)
                        .background(.green.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 25))
                    .scaleEffect(2)
                    Spacer()
                    Button("Next Level > "){
                        
                    }
                    .foregroundStyle(.white)
                    .padding()
                    .background(.blue.opacity(0.5))
                    .clipShape(.rect(cornerRadius: 15))
                    .padding(.top,50)
                    Spacer(minLength: 150)
                    
                }
                .foregroundStyle(.white)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    VStack{
        GameplayView()
    }
    
}
