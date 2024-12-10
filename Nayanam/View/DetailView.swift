//
//  DetailView.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var  postDetail:PostDetailModel?
    @State private var isDetailShown = false
    
    var id:Int?
    init(id:Int? = 0) {
        self.id = id
    }
    
    var body: some View {
        
        VStack {
            if isDetailShown {
                ScrollView{
                    VStack(spacing: 0) {
                        
                        if let imageURL = postDetail?.photoModelVec?[0].specMap?.lg?.url {
                            URLImage(imageURL, width: UIScreen.main.bounds.width, fixedHeight: UIScreen.main.bounds.height - 220)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 220)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 10) {
                                if let profileImg = postDetail?.ownerModel?.photoModel?.specMap?.md?.url {
                                    URLImage(profileImg, width: 50, fixedHeight: 50)
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                                VStack(alignment: .leading, spacing: 3) {
                                    Text("\(postDetail?.ownerModel?.firstName ?? "")\(postDetail?.ownerModel?.lastName ?? "")")
                                        .font(.custom("robotoserif", size: 18))
                                        .foregroundColor(Color(hex: "565656"))
                                    
                                    let timestamp: TimeInterval = postDetail?.postModel?.createdAt ?? 0 / 1_000_000_000
                                    Text("Post created \(timestamp, specifier: "%.0f")")
                                        .timeAgo(timestamp: timestamp)
                                        .font(.custom("Roboto-Medium", size: 15))
                                        .foregroundColor(Color(hex: "565656"))
                                }
                                
                            }
                            
                            
                            Text(postDetail?.postModel?.text ?? "")
                                .font(.custom("Roboto-Bold", size: 16))
                                .foregroundColor(Color(hex: "4f4f4f"))
                                .multilineTextAlignment(.leading)
                            
                            if let likeCount = postDetail?.postModel?.likeCount, let commentCount = postDetail?.postModel?.commentCount, likeCount == 0 && commentCount == 0 {
                                // This will hide the entire HStack if both likeCount and commentCount are 0
                            } else {
                                HStack {
                                    HStack(spacing: 12) {
                                        Image("like")
                                            .resizable()
                                            .frame(width: 22,height: 22)
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.red)
                                        
                                        Text("\(postDetail?.postModel?.likeCount ?? 0) Likes")
                                            .font(.custom("Roboto-Medium", size: 15))
                                            .foregroundColor(Color(hex: "3b71ca"))
                                    }
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 5) {
                                        if let commentCount = postDetail?.postModel?.commentCount, commentCount > 0 {
                                            Text("\(commentCount) Comment")
                                                .font(.custom("Roboto-Regular", size: 15))
                                                .foregroundColor(Color(hex: "757575"))
                                        }
                                    }
                                    
                                }
                                .padding(.top,12)
                            }
                            
                        }
                        .padding(.top,25)
                        .padding(.leading,25)
                        .padding(.trailing,25)
                        .padding(.bottom,10)
                    }
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(0)
                    VStack(spacing: 0) {
                        Text("Recent Comment")
                            .font(.custom("Roboto-Medium", size: 18))
                            .foregroundColor(Color(hex: "332D2D"))
                            .frame(height: 40)
                            .padding(.leading,-170)
                            .padding(.top,10)
                        if let commentArray = postDetail?.commentModelVec {
                            ForEach(0..<commentArray.count) { index in
                                CommentView(item: commentArray,index:index)
                            }
                        }
                    }
                    
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding(.top,10)
                    
                }
                
            }else{
                loader()
            }
            
        }
        .padding(.horizontal)
        .navigationBarTitle("Card Detail", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("back")
                .resizable()
                .renderingMode(.original)
        }
        )
        .onAppear {
            fetchDetailData(for: id ?? 0)
            
        }
        
        
    }
    private func loader() -> some View {
        ZStack {
            if !isDetailShown {
                Circle()
                    .trim(from: 0, to: 0.9)
                    .stroke(Color(hex: "#e4a11b"), lineWidth: 6)
                    .frame(width: 60, height: 60)
                    .rotationEffect(Angle(degrees: !isDetailShown ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
            }
        }
        .frame(maxWidth: 60, maxHeight: 60)
    }
    private func fetchDetailData(for postId: Int) {
        
        guard var urlComponents = URLComponents(string: "https://api.nayanam.ai/api/v1/post") else {
            print("Invalid URL")
            
            return
        }
        
        // Convert postId to String
        let postIdString = String(postId)
        
        print(postIdString)
        urlComponents.queryItems = [URLQueryItem(name: "postId", value: postIdString)]
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            
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
                let posts = try JSONDecoder().decode(DetailModel.self, from: data)
                self.isDetailShown = true
                self.postDetail = posts.postDetailModel
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume()
    }
    
}

#Preview {
    DetailView(id:0)
}
