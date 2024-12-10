//
//  CommentView.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI

struct CommentView: View {
    
    var item: [CommentModelVec]?
    var index:Int?
    
    init(item: [CommentModelVec]? = nil,index:Int? = 0) {
        self.index = index
        self.item = item
    }
    
    var body: some View {
        HStack {
         
            if let imageUrl = item?[index ?? 0].ownerModel?.socialProfilePhotoURL,
               let url = URL(string: imageUrl) {
                // If image URL exists, display the image using URLImage
                URLImage(imageUrl, width: 50, fixedHeight: 50)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .cornerRadius(25)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
            }
            
            
            VStack(alignment: .leading) {
                Rectangle()
                    .frame(height: 1)
                    .padding(.leading, -80)
                    .padding(.trailing, -10)
                    .padding(.top, 0)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 3) {
                    
                    
                    Text("\(item?[index ?? 0].ownerModel?.firstName ?? "") \(item?[index ?? 0].ownerModel?.lastName ?? "")")
                        .font(.custom("Roboto-Medium", size: 16))
                        .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.18, blue: 0.18, alpha: 1)))
                    
                    let formattedDate = commentDate(time: Int(item?[index ?? 0].createdAt ?? 0))
                    Text(formattedDate)
                    //                    Text("Month")
                    
                        .font(.custom("Roboto-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.46, green: 0.46, blue: 0.46, alpha: 1)))
                    
                    
                    Text(item?[index ?? 0].text ?? "")
                        .font(.custom("Roboto-Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.18, blue: 0.18, alpha: 1)))
                }
                .padding(.trailing,60)
                .padding(.leading,0)
                .padding(.top,15)
                .padding(.bottom,10)
                Spacer()
            }
            Spacer()
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView(item: [],index: 0)
    }
}
