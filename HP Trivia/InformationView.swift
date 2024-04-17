//
//  InformationView.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 23/04/24.
//

import SwiftUI

struct InformationView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack{
            InfoBackgroundView()
            
            VStack{
                Image(.appiconwithradius)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .padding()
                ScrollView {
                                    // Title
                                    Text("How To Play")
                                        .font(.largeTitle)
                                        .padding()
                                    
                                    // Instructions
                                    VStack(alignment: .leading) {
                                        Text("Welcome to HP Trivia! In this game, you will be asked random questions from the HP books and you must guess the right answer or you will lose points!😱")
                                            .padding([.horizontal, .bottom])
                                        
                                        Text("Each question is worth 5 points, but if you guess a wrong answer, you lose 1 point.")
                                            .padding([.horizontal, .bottom])
                                        
                                        Text("If you are struggling with a question, there is an option to reveal a hint or reveal the book that answers the question. But beware! Using these minuses 1 point each.")
                                            .padding([.horizontal, .bottom])
                                        
                                        Text("When you select the correct answer, you will be awarded all the points left for tat question and they will be added to your total score.")
                                            .padding(.horizontal)
                                    }.font(.title3)
                                    
                                    Text("Good luck!")
                                        .font(.title)
                                }
                .padding(.horizontal,90)
                                .foregroundColor(.black)
                Button("Done"){
                    dismiss()
                }
                .doneButton()
                
            }
        }
    }
}

#Preview {
    InformationView()
}
