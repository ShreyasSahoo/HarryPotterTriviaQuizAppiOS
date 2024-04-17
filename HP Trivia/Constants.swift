//
//  Constants.swift
//  HP Trivia
//
//  Created by Shreyas Sahoo on 17/04/24.
//

import SwiftUI

enum Constants  {
    static let hpFont = "PartyLetPlain"
}

struct InfoBackgroundView : View {
    var body : some View {
        Image(.parchment)
            
            .resizable()
            
            .ignoresSafeArea()
            .background(.brown)
            
    }
   
}

extension Button {
    
    func doneButton() -> some View {
        self
            .padding()
            .font(.largeTitle)
            .foregroundStyle(.white)
            .buttonStyle( .borderedProminent )
            .tint(.brown)
    }
    
}
