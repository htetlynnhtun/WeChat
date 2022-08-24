//
//  ChatImagePicker.swift
//  WeChat
//
//  Created by kira on 06/08/2022.
//

import SwiftUI
import PhotosUI

struct ChatImagePicker: View {
    
    @EnvironmentObject var chatVM: ChatViewModel
    
    @State private var loadedImages = [LoadedImage]()
    @State private var isAuthorized = true
    
    private let gridItems = Array(repeating: GridItem(.flexible(), spacing: 8), count: 3)
    private let imageItemWidth = (UIScreen.main.bounds.width - 42) / 3
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridItems) {
                ForEach(loadedImages, id: \.self) { loadedImage in
                    LoadedImageItemView(loadedImage: loadedImage, selectedImages: $chatVM.selectedImages)
                        .frame(width: imageItemWidth, height: imageItemWidth)
                }
            }
        }
        .onAppear {
            PHPhotoLibrary.requestAuthorization { status in
                if (status == .authorized) {
                    loadAllImages()
                    isAuthorized = true
                } else {
                    print("Not authorized")
                    isAuthorized = false
                }
            }
        }
    }
    
    private func loadAllImages() {
        let fetchResults = PHAsset.fetchAssets(with: .image, options: .none)
//        if let filename = e?.value(forKey: "filename") as? String {
//            let ex = URL(fileURLWithPath: filename).pathExtension
//            print(ex)
//        }
        
        DispatchQueue.global(qos: .background).async {
            let imageRequestOptions = PHImageRequestOptions()
            imageRequestOptions.isSynchronous = true
            
            for i in 0..<fetchResults.count {
                PHCachingImageManager.default().requestImage(for: fetchResults[i], targetSize: .init(width: imageItemWidth, height: imageItemWidth), contentMode: .aspectFill, options: imageRequestOptions) { uiImage, _ in
                    if let uiImage = uiImage {
                        let loadedImage = LoadedImage(image: uiImage,
                                                      selected: false,
                                                      asset: fetchResults[i])
                        loadedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}

struct LoadedImage: Hashable {
    var image : UIImage
    var selected : Bool
    var asset : PHAsset
    var data: Data?
}

struct SelectedImage {
    var image : UIImage
    var asset : PHAsset
    var data: Data?
}
