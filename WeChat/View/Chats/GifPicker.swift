//
//  GifPicker.swift
//  WeChat
//
//  Created by kira on 24/08/2022.
//

import SwiftUI
import PhotosUI

struct GifPicker: View {
    
    @EnvironmentObject var chatVM: ChatViewModel
    
    @State private var loadedImages = [LoadedImage]()
    @State private var isAuthorized = true
    
    private let gridItems = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    private let imageItemWidth = (UIScreen.main.bounds.width - 42) / 3
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridItems) {
                ForEach(loadedImages, id: \.self) { loadedImage in
                    LoadedGifItemView(loadedImage: loadedImage, selectedImages: $chatVM.selectedGifs)
                        .frame(width: imageItemWidth, height: imageItemWidth)
                }
            }
        }
        .onAppear {
            PHPhotoLibrary.requestAuthorization { status in
                if (status == .authorized) {
                    loadAllGif()
                    isAuthorized = true
                } else {
                    print("Not authorized")
                    isAuthorized = false
                }
            }
        }
    }
    
    private func loadAllGif() {
        let fetchResults = PHAsset.fetchAssets(with: .image, options: .none)
        
        DispatchQueue.global(qos: .background).async {
            let imageRequestOptions = PHImageRequestOptions()
            imageRequestOptions.isSynchronous = true
            
            for i in 0..<fetchResults.count {
                let asset = fetchResults[i]
                
                let filename = asset.value(forKey: "filename") as! String
                let fileExtension = URL(fileURLWithPath: filename).pathExtension
                
                if (fileExtension == "GIF") {
                    var imageData: Data?
                    
                    PHCachingImageManager.default().requestImageDataAndOrientation(for: asset, options: imageRequestOptions) { data, _, __, ___ in
                        imageData = data
                    }
                    
                    PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(width: imageItemWidth, height: imageItemWidth), contentMode: .aspectFill, options: imageRequestOptions) { uiImage, _ in
                        if let uiImage = uiImage {
                            let loadedImage = LoadedImage(image: uiImage,
                                                          selected: false,
                                                          asset: asset,
                                                          data: imageData)
                            loadedImages.append(loadedImage)
                        }
                    }
                }
                
            }
        }
    }
    
}

struct GifPicker_Previews: PreviewProvider {
    static var previews: some View {
        GifPicker()
    }
}
