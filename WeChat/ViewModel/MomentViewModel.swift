//
//  MomentViewModel.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import Foundation
import UIKit

class MomentViewModel: ObservableObject {
    
    private let model: MomentModel = MomentModelImpl.shared
    private let storageModel: StorageModel = StorageModelImpl.shared
    
    @Published var isPresentingNewMoment = false
    @Published var textEditorValue = ""
    @Published var selectedUIImages = [UIImage]()
    @Published var moments = [MomentVO]()
    
    @Published var showActivityIndicator = false
    @Published var toastMessage = ""
    @Published var isShowingToast = false
    
    init() {
        model.getMoments { [weak self] moments in
            self?.moments = moments
        }
    }
    
    func onViewAddNewMomentScreen() {
        textEditorValue = ""
        selectedUIImages = []
    }
    
    func onTapCreateMoment(userVO: UserVO) {
        guard textEditorValue.isNotEmpty,
              !selectedUIImages.isEmpty else {
            return
        }
        
        showActivityIndicator = true
        let dispatchGroup = DispatchGroup()
        var uploadedImages = [URL]()
        
        selectedUIImages.forEach { image in
            dispatchGroup.enter()
            
            if let data = image.pngData() {
                storageModel.uploadImage(imageData: data, to: momentImagesDir) { url in
                    uploadedImages.append(url)
                    
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            let momentVO = MomentVO(bookmarks: [],
                                    createdAt: Date.now,
                                    description: self.textEditorValue,
                                    likes: [],
                                    mediaFiles: uploadedImages,
                                    profilePicture: userVO.profilePicture,
                                    username: userVO.name)
            
            self.model.createMoment(payload: momentVO) { result in
                self.showActivityIndicator = false
                
                switch result {
                case .success(_):
                    print("Create moment success")
                    self.isPresentingNewMoment = false
                    
                case .failure(let error):
                    self.toastMessage = error.message
                    self.isShowingToast = true
                }
            }
        }
    }
}
