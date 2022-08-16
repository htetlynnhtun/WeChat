//
//  PhotoPicker.swift
//  WeChat
//
//  Created by kira on 03/08/2022.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImages: [UIImage]
    private let selectionLimit: Int
    
    init(isPresented: Binding<Bool>, selectedImages: Binding<[UIImage]>, selectionLimit: Int = .max) {
        self._isPresented = isPresented
        self._selectedImages = selectedImages
        self.selectionLimit = selectionLimit
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = selectionLimit

        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            for result in results {
                let itemProvider = result.itemProvider
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let image = image as? UIImage else {
                            return
                        }
                        
                        DispatchQueue.main.async {
                            self?.parent.selectedImages.append(image)
                        }
                    }
                }
            }
            parent.isPresented = false
        }
    }
}
