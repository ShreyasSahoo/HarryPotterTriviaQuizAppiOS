//
//  GameplayView.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 23/04/24.
//

import SwiftUI
import AVKit
struct GameplayView: View {
    @Environment(\.dismiss) var dismiss
    @Namespace private var namespace
    @State private var animateViewsIn = false
    @State private var tappedCorrectAnswer = false
    @State private var wrongAnswersTapped : [Int] = []
    @State private var wiggle = false
    @State private var scaleNextButton = false
    @State private var movePointsToScore = false
    @State private var revealHint = false
    @State private var revealBook = false
    @State private var backgroundPlayer : AVAudioPlayer!
    @State private var sfxPlayer : AVAudioPlayer!
    private var tempAnswers = [true, false,false, false]
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
                //MARK: Question Screen
                 VStack{
                    HStack{
                        Button("End Game"){
                            // MARK: Controls
                            dismiss()
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
                                .opacity(tappedCorrectAnswer ? 0.1 : 1)
                        }
                    }
                    .animation(.easeInOut(duration: animateViewsIn ? 2 : 0),value: animateViewsIn)
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
                                    .padding()
                                    .padding(.trailing,20)
                                    .transition(.offset(x:-geo.size.width/2))
                                    .rotationEffect(.degrees(wiggle ? -13 : -17))
                                    .onAppear{
                                        withAnimation(
                                            .easeInOut(duration: 0.1)
                                            .repeatCount(9)
                                            .delay(5)
                                            .repeatForever()){
                                                wiggle = true
                                            }
                                        
                                        
                                    }
                                    .onTapGesture {
                                        withAnimation(.easeIn(duration: 1)){
                                            revealHint = true
                                        }
                                        playFlipSound()
                                    }
                                    .rotation3DEffect(
                                        .degrees(revealHint ? 1440 : 0),
                                                              axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                                    )
                                    .scaleEffect(revealHint ? 5 : 1)
                                    .opacity(revealHint ? 0 : 1)
                                    .offset(x : revealHint ? geo.size.width/2  : 0)
                                    .overlay(
                                    Text(" The boy who ... ")
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.5)
                                        .opacity(revealHint ? 1 : 0)
                                        .scaleEffect(revealHint ? 1.33 : 1)
                                        .padding([.trailing,.bottom])

                                    )
                                    .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                    .disabled(tappedCorrectAnswer)
                            }
                        }
                        .animation(.easeOut(duration: animateViewsIn ? 1.5 : 0).delay(animateViewsIn ? 2 : 0 ),value:animateViewsIn)
                        Spacer()
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
                            .rotationEffect(.degrees(wiggle ? 13 : 17))
                            .onAppear{
                                withAnimation(
                                    .easeInOut(duration: 0.1)
                                    .repeatCount(9)
                                    .delay(5)
                                    .repeatForever()){
                                        wiggle = true
                                    }
                                
                            }
                            .onTapGesture {
                                withAnimation(.easeIn(duration: 1)){
                                    revealBook = true
                                }
                                playFlipSound()
                            }
                            .rotation3DEffect(
                                .degrees(revealBook ? 1440 : 0),
                                                      axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
                            )
                            .scaleEffect(revealBook ? 5 : 1)
                            .opacity(revealBook ? 0 : 1)
                            .offset(x : revealBook ? -geo.size.width/2  : 0)
                            .overlay(
                            Image("hp1")
                                
                                .resizable()
                                .scaledToFit()
                                .padding([.trailing,.bottom])
                                .opacity(revealBook ? 1 : 0)
                                .scaleEffect(revealBook ? 1.33 : 1)
                            )
                            .opacity(tappedCorrectAnswer ? 0.1 : 1)
                            .disabled(tappedCorrectAnswer)
                           
                            }
                        }
                        .animation(.easeOut(duration: animateViewsIn ? 1.5 : 0 ).delay(animateViewsIn ? 2 : 0),value:animateViewsIn)
                    }
                    .padding([.bottom,.horizontal])
                    // MARK: Answers
                    LazyVGrid(columns: [GridItem(),GridItem()]){
                        ForEach(1..<5){ i in
                            if tempAnswers[i-1] == true {
                                VStack{
                                    if animateViewsIn {
                                        if tappedCorrectAnswer == false {
                                            Text("Answer \(i)")
                                                .minimumScaleFactor(0.5)
                                                .multilineTextAlignment(.center)
                                                .padding()
                                                .frame(width: geo.size.width/2.15, height: 80)
                                                .background(.green.opacity(0.5))
                                            .clipShape(.rect(cornerRadius: 25))
                                            .transition(.asymmetric(insertion: .scale, removal: .scale(scale: 5).combined(with: .opacity.animation(.easeOut(duration: 0.5)))))
                                            .matchedGeometryEffect(id: "answer", in: namespace)
                                            .onTapGesture {
                                                withAnimation(.easeIn(duration: 1)){
                                                    tappedCorrectAnswer = true
                                                }
                                                playCorrectSound()
                                            }
                                        }
                                       
                                    }
                                }
                                .animation(.easeOut(duration: animateViewsIn ? 1 : 0 ).delay(animateViewsIn ? 1.5 : 0), value: animateViewsIn)
                            }
                            else {
                                VStack{
                                    if animateViewsIn {
                                        Text("Answer \(i)")
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.center)
                                            .padding()
                                            .frame(width: geo.size.width/2.15, height: 80)
                                            .background(wrongAnswersTapped.contains(i) ? .red.opacity(0.5) : .green.opacity(0.5))
                                        .clipShape(.rect(cornerRadius: 25))
                                        .transition(.scale)
                                        .onTapGesture {
                                            withAnimation(.easeOut(duration: 0.5)){
                                                wrongAnswersTapped.append(i)
                                            }
                                            playWrongSound()
                                            giveWrongFeedback()
                                        }
                                        .scaleEffect(wrongAnswersTapped.contains(i) ? 0.8 : 1)
                                        .opacity(tappedCorrectAnswer ? 0.1 : 1)
                                        .disabled(tappedCorrectAnswer || wrongAnswersTapped.contains(i))
                                    }
                                }
                                .animation(.easeOut(duration: animateViewsIn ? 1 : 0).delay(animateViewsIn ? 1.5 : 0), value: animateViewsIn)
                            }
                            
                        }
                    }
                    Spacer()
                }
                 .foregroundStyle(.white)
                 .frame(width: geo.size.width, height: geo.size.height)
                 

                       
                //MARK: Celebration Screen
                VStack{
                    Spacer()
                    VStack{
                        if tappedCorrectAnswer{
                            Text("5")
                                .font(.largeTitle)
                                .padding(.bottom)
                                .transition(.move(edge: .top))
                                .offset(x : movePointsToScore ? geo.size.width/2.5 : 0 , y : movePointsToScore ? -geo.size.height/15 : 0)
                                .opacity(movePointsToScore ? 0:1)
                                .onAppear{
                                    withAnimation(.easeInOut(duration: 1).delay(1)){
                                        movePointsToScore = true
                                    }
                                }
                            
                            Text("Brilliant!")
                                .font(.custom(Constants.hpFont, size: 100))
                                .transition(.move(edge: .top))
                        }
                        
                                 

                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 1 : 0), value: tappedCorrectAnswer)
                    
                    
                    Spacer()
                    if tappedCorrectAnswer{
                        Text("Answer 1")
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: geo.size.width/2.15, height: 80)
                            .background(.green.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 25))
                            .scaleEffect(2)
                            .matchedGeometryEffect(id: "answer", in: namespace)
                    }
                    
                    Spacer()
                    VStack{
                        if tappedCorrectAnswer{
                            Button("Next Level > "){
                                animateViewsIn = false
                                tappedCorrectAnswer = false
                                wrongAnswersTapped = []
                                revealHint = false
                                revealBook = false
                                wiggle = false
                                movePointsToScore = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    animateViewsIn = true
                                }
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(.blue.opacity(0.5))
                            .clipShape(.rect(cornerRadius: 15))
                            .padding(.top,50)
                            .transition(.move(edge: .bottom))
                            .scaleEffect(scaleNextButton ? 1.2 : 1)
                            .onAppear{
                                withAnimation(.easeInOut(duration:1.3).delay(1).repeatForever()){
                                    scaleNextButton.toggle()
                                }
                            }
                        }
                    }
                    .animation(.easeInOut(duration: tappedCorrectAnswer ? 1 : 0), value:tappedCorrectAnswer)
                    
                   
                    
                    Spacer(minLength: 150)

                
                }
                .animation(.easeInOut(duration: 1),value: tappedCorrectAnswer)
                .foregroundStyle(.white)
                
                
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .onAppear  {
           animateViewsIn = true
//            playMusic()
        }
        .ignoresSafeArea()
    }
     
    private func playMusic(){
        let songs = ["let-the-mystery-unfold","spellcraft","hiding-place-in-the-forest","deep-in-the-dell"]
        
        let i = Int.random(in: 0...3)
        
        let sound = Bundle.main.path(forResource: songs[i], ofType: "mp3")
        backgroundPlayer = try! AVAudioPlayer(contentsOf: URL(filePath : sound!))
        backgroundPlayer.volume = 0.1
        backgroundPlayer.numberOfLoops = -1
        backgroundPlayer.play()

     }
    private func playFlipSound(){
        let sound = Bundle.main.path(forResource: "page-flip", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath : sound!))
        sfxPlayer.play()
     }
    private func playCorrectSound(){
        let sound = Bundle.main.path(forResource: "magic-wand", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath : sound!))
        sfxPlayer.play()
     }
    private func playWrongSound(){
        let sound = Bundle.main.path(forResource: "negative-beeps", ofType: "mp3")
        sfxPlayer = try! AVAudioPlayer(contentsOf: URL(filePath : sound!))
        sfxPlayer.play()
     }
    
    private func giveWrongFeedback(){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
}

#Preview {
    VStack{
        GameplayView()
    }
    
}
