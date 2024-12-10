//
//  URLImage.swift
//  Nayanam
//
//  Created by meet sharma on 09/05/24.
//

import SwiftUI


struct URLImage: View {
    let url: URL
    @State private var imageData: Data?
    let width: CGFloat
    let height: CGFloat // Add a fixed height property
    
    init(_ urlString: String, width: CGFloat, fixedHeight: CGFloat) {
        self.url = URL(string: urlString) ?? URL(fileURLWithPath: "")
        self.width = width
        self.height = fixedHeight // Initialize fixedHeight
    }
    
    var body: some View {
        if let imageData = imageData,
           let uiImage = UIImage(data: imageData) {
            VStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: width, height: height)
                     .aspectRatio(CGSize(width:width, height: height), contentMode: .fit)
            }
        } else {
            Image("")
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(width: width, height: height) // Set fixed height
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                self.imageData = data
            }
        }.resume()
    }
}
