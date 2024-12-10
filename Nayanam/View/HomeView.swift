//
//  HomeView.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct HomeView: View {
    @State private var albums: [PostModelVec] = []
    @State private var currentPage = 0
    @State private var isDetailShown = false
    @State private var isLoading = false
    @State private var hasFetchedData = false
    
    var body: some View {
        
        ZStack {
            Color(UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0))
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                
                ViewPager(currentPage: $currentPage, isDetailShown: $isDetailShown, albums: albums)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            if !isDetailShown {
                VStack {
                    Spacer()
                    HStack(spacing: 20) {
                        CardView(image: "cards", text: "Trending")
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#e4a11b"))
                            .cornerRadius(5.0)
                            .onTapGesture {
                                currentPage = 0
                                
                            }
                        CardView(image: "searchicon", text: "Search")
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: "#e4a11b")).cornerRadius(5.0)
                            .onTapGesture {
                                currentPage = 1
                            }
                    }
                    
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 3, trailing: 15))
                    .background(Color(UIColor(red: 51/255, green: 45/255, blue: 45/255, alpha: 1.0)))
                }
              
            }
            if !hasFetchedData {
                Circle()
                    .trim(from: 0, to: 0.9)
                    .stroke(Color(hex: "#e4a11b"), lineWidth: 6)
                    .frame(width: 60, height: 60)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                    .padding(.top, -100)
                    .frame(maxWidth: 60, maxHeight: 60)
            }
        }
        
        .navigationTitle("Trending")
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .onAppear {
            
            fetchRemoteData()
        }
    }
    
    private func fetchRemoteData() {
        isLoading = true
        guard !hasFetchedData else { return }
            let url = URL(string: "https://api.nayanam.ai/api/v1/posts")!
            var request = URLRequest(url: url)
            request.httpMethod = "GET"  // optional
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: request){ data, response, error in
               
                
                if let error = error {
                    print("Error while fetching data:", error)
                    isLoading = false
                    return
                }

                guard let data = data else {
                    return
                }

                do {
                    let posts = try JSONDecoder().decode(TrendingModel.self, from: data)
                    self.albums.removeAll()
                    self.albums = posts.postModelVec ?? []
                    self.isLoading = false
                    self.hasFetchedData = true
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }

            task.resume()
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct CardView: View {
    var image: String
    var text: String
    
    var body: some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 18, height: 18)
                .padding(.trailing, 10)
            
            Text(text)
                .font(.custom("Roboto-Regular", size: 18))
                .foregroundColor(Color.white)
                .padding(.vertical)
        }
    }
}

struct ViewPager: View {
    @Binding private var currentPage: Int
    @Binding private var isDetailShown: Bool

    var albums: [PostModelVec]
    
    init(currentPage: Binding<Int>, isDetailShown: Binding<Bool>, albums: [PostModelVec]) {
        self._currentPage = currentPage
        self._isDetailShown = isDetailShown
        self.albums = albums
    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<2) { index in
                    ScrollView {
                        if index == 0 {
                            ScrollView {
                                VStack(spacing: 0) {
                                    ForEach(albums.indices, id: \.self) { albumIndex in
                                        NavigationLink(destination: DetailView(id: albums[albumIndex].id)) {
                                            TrendingView(item: albums, index: albumIndex)
                                        }
                                    }
                                }
                            }
                            .navigationBarTitle("Trending")
                        } else {
                            SearchView()
                                .navigationBarTitle("Search")
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
           
        }
    }
}


struct ListItem: View {
    var index: Int
    
    var body: some View {
        
        Text("Item \(index)")
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .listRowInsets(EdgeInsets())
            .foregroundColor(Color.black)
        
    }
}

