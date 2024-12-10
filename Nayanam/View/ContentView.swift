//
//  ContentView.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    var body: some View {
        ZStack{
            if showSplash{
                SplashScreenView()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1.5))
            }else{
                NavigationView {
                    VStack {
                        HStack {
                            Image("n")
                                .resizable()
                                .frame(width: 38, height: 38)
                                .padding(.leading,5)
                            
                            Spacer()
                        }
                        ScrollView {
                            GeometryReader { geometry in
                                ZStack(alignment: .center) {
                                    Image("serchbg1")
                                        .resizable()
                                        .frame(height: 220)
                                        .aspectRatio(contentMode: .fit)
                                        .padding(.trailing,0)
                                        .padding(.top, 0)
                                        .padding(.leading,0)
                                        .frame(width: UIScreen.main.bounds.size.width)
                                        .overlay(Color.black.opacity(0.5))
                                    Image("apptaxt")
                                        .resizable()
                                        .frame(height: 35)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:220)
                                        .padding(.leading,20)
                                        .padding(.trailing,20)
                                        .padding(.top, 15)
                                    
                                    
                                    Text("Visual Learning Network")
                                        .font(.custom("Roboto-Regular", size: 19))
                                        .padding(.top, 110)
                                        .padding(.leading, 10)
                                        .padding(.trailing, 10)
                                        .foregroundColor(Color.white)
                                    
                                    
                                }
                                Rectangle()
                                    .frame(height: 1)
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.top, 138)
                                    .foregroundColor(.white)
                                Text("Why Nayanam?")
                                    .font(.custom("Roboto-Medium", size: 18))
                                
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 250)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color.black)
                                let mainText = "At Nayanam, we believe that learning with visuals and examples is easier than traditional reading.\n\nWelcome to a new era of learning with our Gyan Cards, where Gyan stands for Knowledge in Sanskrit, the ancient Indian language. Each card serves as a knowledge unit, illustrating concepts with engaging visuals."
                                
                                Text(mainText)
                                    .font(.custom("Roboto-Regular", size: 16))
                                    .padding([.leading, .trailing], 34)
                                    .tracking(0.1)
                                    .frame(maxWidth: .infinity)
                                    .padding(.top, 290)
                                    .multilineTextAlignment(.center)
                                
                                    .lineLimit(nil)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .foregroundColor(Color(hex: "#4f4f4f"))
                                
                                
                            }
                        }
                        Spacer()
                        
                        NavigationLink(destination: HomeView()) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color(hex:"#e4a11b"))
                                .frame(width: 150, height: 40)
                                .overlay(
                                    Text("Next")
                                        .font(.custom("Roboto-Regular", size: 18))
                                        .foregroundColor(.white)
                                )
                                .padding(.bottom, 20)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.leading, 0)
                    .padding(.trailing, 0)
                    
                    
                }
                
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0){
                withAnimation {
                    showSplash = false
                }
            }
        }
        
        .navigationBarHidden(true)
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
