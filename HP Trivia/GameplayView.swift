//
//  GameplayView.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 23/04/24.
//

import SwiftUI

struct GameplayView: View {
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
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red.opacity(0.5))
                        
                        Spacer()
                        Text("Score : 33")
                    }
                    .padding()
                    
                    Text("Who is Harry Potter?")
                        .font(.custom(Constants.hpFont, size: 50))
                    
                    HStack{
                        Image(systemName: "questionmark.app.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundStyle(.cyan)
                            .rotationEffect(.degrees(-15))
                            .padding()
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
                    }
                }
                .foregroundStyle(.white)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GameplayView()
}
