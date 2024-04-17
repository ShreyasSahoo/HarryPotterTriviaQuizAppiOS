//
//  ContentView.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 17/04/24.
//

import SwiftUI
import AVKit
struct ContentView: View {
    @State private var scalePlayButton = false
    @State private var moveBackgroundImage = false
    @State private var animateViewsIn = false
    @State private var showInfoView = false
    @State private var audioPlayer : AVAudioPlayer!
    var body: some View {
        
        GeometryReader { geo in
            ZStack{
                Image("hogwarts")
                    .resizable()
                    .frame(width:geo.size.width*3,height:geo.size.height)
                    .padding(.top,5)
                    .offset(x: moveBackgroundImage ? geo.size.width/1.1 : -geo.size.width/1.1)
                    .onAppear{
                        withAnimation(.linear(duration: 60).repeatForever()){
                            moveBackgroundImage.toggle()
                        }
                    }
                
                VStack{
                    VStack{
                        if animateViewsIn {
                            VStack{
                                Image(systemName: "bolt.fill")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                
                                Text("HP")
                                    .font(.custom(Constants.hpFont,size:70))
                                Text("Trivia")
                                    .font(.custom("PartyLetPlain",size:60))
                            }
                            .transition(.move(edge: .top))
                            .padding(.top,70)
                        }
                    }
                    .animation(.linear(duration:1).delay(2),value:animateViewsIn)
                    Spacer()
                    VStack{
                        if animateViewsIn {
                            VStack{
                                Text("Recent Scores")
                                Text("33")
                                Text("39")
                                Text("43")
                                
                            }
                            .transition(.opacity)
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.black.opacity(0.7))
                        .clipShape(.rect(cornerRadius: 10))
                        }

                    }
                    .animation(.linear(duration:2).delay(3), value: animateViewsIn)
                                        Spacer()
                    HStack{
                        Spacer()
                        VStack{
                            if animateViewsIn {
                                    Button{
                                        showInfoView.toggle()
                                    } label : {
                                        Image(systemName: "info.circle.fill")
                                            .font(.largeTitle)
                                            .foregroundStyle(.white)
                                }
                                    .transition(.offset(x:-geo.size.width/4))
                                    .sheet(isPresented: $showInfoView, content: {
                                        InformationView()
                                    })
                        }
                        
                               
                        }
                        .animation(.linear(duration:1).delay(2),value:animateViewsIn)
                        Spacer()
                        VStack{
                            if animateViewsIn {
                                Button{
                                } label: {
                                    Text("Play")
                                        .font(.title)
                                        .foregroundStyle(.white)
                                        .padding(.vertical,7)
                                        .padding(.horizontal,50)
                                        .background(.brown)
                                        .clipShape(.rect(cornerRadius: 7))
                                        .shadow(radius: 5)
                                }
                                .transition(.offset(y:geo.size.height/3))
                                .scaleEffect(scalePlayButton ? 1.2 : 1)
                                .onAppear{
                                    withAnimation(.easeIn(duration: 1.3).repeatForever()){
                                        scalePlayButton.toggle()
                                    }
                            }
                            }

                        }
                        .animation(.linear(duration:1).delay(2), value:animateViewsIn)
                        Spacer()
                        VStack{
                            if animateViewsIn {
                                Button{
                                    
                                } label : {
                                    Image(systemName: "gearshape.fill")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                        .shadow(radius: 5)
                            }
                                .transition(.offset(x:geo.size.width/4))
                            }
                        }
                        .animation(.linear(duration:1).delay(2),value:animateViewsIn)
                        
                        Spacer()
                    }
                    .frame(width: geo.size.width)
                    Spacer()
                }
                
            }
            .frame(width: geo.size.width,height:geo.size.height)
        }
        .ignoresSafeArea()
        .onAppear{
            animateViewsIn = true
            playAudio()
        }
    }
   private func playAudio(){
       let sound = Bundle.main.path(forResource: "magic-in-the-air", ofType: "mp3")
       audioPlayer = try! AVAudioPlayer(contentsOf: URL( filePath : sound! ))
       audioPlayer.numberOfLoops = -1
//       audioPlayer.play()
    }
}

#Preview {
    ContentView()
//        .preferredColorScheme(.dark)
}
