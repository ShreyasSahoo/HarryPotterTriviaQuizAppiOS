//
//  SettingsView.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 23/04/24.
//

import SwiftUI
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var store : Store
    var body: some View {
        ZStack{
            InfoBackgroundView()
            VStack{
                Text("Which books would you like the questions to be from?")
                    .font(.title)
                    .multilineTextAlignment(.center)
                ScrollView{
                    LazyVGrid(columns: [GridItem(),GridItem()]){
                        ForEach(0..<7){ i in
                            if store.books[i] == .active || (store.books[i] == .locked && store.purchasedIDs.contains("hp\(i+1)")) {
                                
                                ZStack(alignment: .bottomTrailing){
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green)
                                        .shadow(radius: 1)
                                        .padding(3)
                                }
                                .task{
                                    store.books[i] = .active
                                }
                                .onTapGesture{
                                    store.books[i] = .inactive
                                }
                                .padding()
                                
                            }
                           
                            else if store.books[i] == .inactive {
                                ZStack(alignment: .bottomTrailing){
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    
                                    Rectangle().opacity(0.33)
                                    
                                    Image(systemName: "circle")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .foregroundStyle(.green.opacity(0.5))
                                        .shadow(radius: 1)
                                        .padding(3)
                                  
                                }
                                .onTapGesture{
                                    store.books[i] = .active
                                }
                                .padding()

                            }
                           
                            else {
                                ZStack(alignment: .center){
                                    Image("hp\(i+1)")
                                        .resizable()
                                        .scaledToFit()
                                        .shadow(radius: 7)
                                    
                                    Rectangle().opacity(0.75)
                                    
                                    Image(systemName: "lock.fill")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .shadow(color:.white,radius: 3)
                                        
                                  
                                }
                                .onTapGesture {
                                    let product = store.products[i-3]
                                    Task{
                                     await store.purchase(product)
                                    }
                                }
                                .padding()
                            }
                            

                        }
                        
                    }
                }
                Button("Done"){
                    dismiss()
                }
                .doneButton()
            }
            
            
        }
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(Store())
}
