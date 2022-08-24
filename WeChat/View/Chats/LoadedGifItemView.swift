//
//  LoadedGifItemView.swift
//  WeChat
//
//  Created by kira on 24/08/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct LoadedGifItemView: View {
    @State var loadedImage: LoadedImage
    @Binding var selectedImages: [SelectedImage]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            AnimatedImage(data: loadedImage.data!)
                .resizable()
            
            if (loadedImage.selected) {
                Color.gray.opacity(0.3)
                
                Image(systemName: "checkmark")
                    .font(.system(size: 16))
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color.colorPrimary)
                    .clipShape(Circle())
                    .padding(8)
            }
        }
        .onTapGesture {
            loadedImage.selected.toggle()
            
            if (loadedImage.selected) {
                selectedImages.append(SelectedImage(image: loadedImage.image, asset: loadedImage.asset, data: loadedImage.data))
            } else {
                selectedImages.removeAll { selectedImage in
                    selectedImage.image == loadedImage.image
                }
            }
        }
    }

}

