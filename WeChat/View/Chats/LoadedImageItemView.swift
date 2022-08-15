//
//  LoadedImageItemView.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI


struct LoadedImageItemView: View {
    @State var loadedImage: LoadedImage
    @Binding var selectedImages: [SelectedImage]
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(uiImage: loadedImage.image)
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
        }
    }
}


