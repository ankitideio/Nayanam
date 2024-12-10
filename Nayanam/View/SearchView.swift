//
//  SearchView.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var searchData: [FeedItemModelVec] = []
    @State private var isLoading = false

   
    var body: some View {
        ZStack {
            Image("serchbg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(Color.black.opacity(0.6))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 50)
                        .cornerRadius(10.0)
                        .foregroundColor(.clear)
                        .padding(.leading, 20)
                        .offset(y: isSearching ? 60 : 0)
                    
                    HStack {
                        TextField("Search for Visuals", text: $searchText)
                            .frame(height: 40)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(5.0)
                            .offset(y: isSearching ? 60 : 0)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                isSearching = true
                                self.fetchSearchData()
                                
                            }
                        }) {
                            Text("SEARCH")
                        }
                        .frame(width: 100, height: 40)
                        .foregroundColor(.white)
                        .background(Color(hex: "#e4a11b"))
                        .cornerRadius(5.0)
                        .padding(.trailing, 0)
                        .offset(y: isSearching ? 60 : 0)
                    }
                }
                
                .padding(.horizontal, 15)
                .padding(.leading,0)
                .padding(.trailing,0)
              
                if isSearching {
                    
                    List {
                        ForEach(searchData.indices, id: \.self) { albumIndex in
                            SearchListView(item: searchData[albumIndex])
                        }
                        
                        .listRowSeparator(.hidden, edges: .all)
                    }
                    
                    .listStyle(PlainListStyle())
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none
                    }
                    .padding(.horizontal,-20)
                    .padding(.top, 120)
                    .padding(.bottom, 0)
                    
                }
                
                Spacer()
            }
            if isLoading {
                Circle()
                    .trim(from: 0, to: 0.9)
                    .stroke(Color(hex: "#e4a11b"), lineWidth: 6)
                    .frame(width: 60, height: 60)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                    .padding(.top, 100)
            }
        }
        .navigationBarTitle( "Search")
  
//        .navigationTitle("Search")
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
    }
   

    private func fetchSearchData() {

        isLoading = true
        guard var urlComponents = URLComponents(string: "https://api.nayanam.ai/api/v1/searchfeed") else {
            print("Invalid URL")
            self.isLoading = false
            return
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "q", value: searchText)]
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            self.isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error while fetching data:", error)
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let posts = try JSONDecoder().decode(SearchModel.self, from: data)
                
                self.searchData.removeAll()
                self.searchData = posts.feedItemModelVec ?? []
                self.isLoading = false
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
