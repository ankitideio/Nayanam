//
//  SplashScreenView.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct SplashScreenView: View {
    
    // State variable to track if the timer has fired
    @State private var timerFired = false
    
    var body: some View {
        
        ZStack {
            Image("splash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            
        }
        
        
    }
}
struct NextScreenView: View {
    var body: some View {
        Text("Next Screen")
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
