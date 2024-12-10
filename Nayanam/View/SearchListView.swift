//
//  SearchListView.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct SearchListView: View {
    
    var item: FeedItemModelVec?
    var index:Int?
    
    init(item: FeedItemModelVec? = nil,index:Int? = 0) {
        
        self.item = item
        
        
    }
    var body: some View {
       
           
            VStack(spacing: 0) {
            
                GeometryReader { geometry in
                    
                    URLImage(item?.postModel?.photoModelVec?[0].specMap?.lg?.url ?? "", width: geometry.size.width, fixedHeight: 180)
                    
                        .frame(height: 180)
                        .padding(0)
                        .overlay(Color.black.opacity(0.5))
                        .mask(
                            Rectangle()
                                .frame(width: geometry.size.width, height:180)
                            
                                .offset(x: 0, y: 0)
                        )
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        
                        URLImage(item?.postModel?.ownerModel?.photoModel?.specMap?.lg?.url ?? "", width: 50, fixedHeight: 50)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("\(item?.postModel?.ownerModel?.firstName ?? "") \(item?.postModel?.ownerModel?.lastName ?? "")")
                                .font(.custom("robotoserif", size: 18))
                                .foregroundColor(Color(hex: "565656"))
                            
                            let timestamp: TimeInterval = item?.postModel?.createdAt ?? 0 / 1_000_000_000
                            Text("Post created \(timestamp, specifier: "%.0f")")
                                .timeAgo(timestamp: timestamp)
                                .font(.custom("Roboto-Medium", size: 15))
                                .foregroundColor(Color(hex: "565656"))
                        }
                    }
                    
                    
                    Text(item?.postModel?.text ?? "")
                        .font(.custom("Roboto-Bold", size: 16))
                        .foregroundColor(Color(hex: "4f4f4f"))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    HStack {
                        
                        HStack(spacing: 12) {
                            if let likeCount = item?.postModel?.likeCount, likeCount != 0 {
                                Image("like")
                                    .resizable()
                                    .frame(width: 22,height: 22)
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.red)
                                
                                Text("\(item?.postModel?.likeCount ?? 0) Likes")
                                    .font(.custom("Roboto-Medium", size: 15))
                                    .foregroundColor(Color(hex: "3b71ca"))
                            }
                        }
                        
                        Spacer()
                        
                        HStack(spacing: 5) {
                            if let commentCount = item?.postModel?.commentCount, commentCount > 0 {
                                Text("\(commentCount) Comment")
                                    .font(.custom("Roboto-Regular", size: 15))
                                    .foregroundColor(Color(hex: "757575"))
                            }
                        }
                    }
                    
                    .padding(.top,item?.postModel?.likeCount == 0 && item?.postModel?.commentCount == 0 ? 0 : 12)
                    // Apply conditional padding here
                    .padding(.bottom, item?.postModel?.likeCount == 0 && item?.postModel?.commentCount == 0 ? 0 : 12)
                    
                }
                .padding(.top,180)
                .padding(.leading,25)
                .padding(.trailing,25)
            }
          
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.top,10)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden()
        
        }
    }
 


#Preview {
    SearchListView(item: nil)
}
