//
//  MeViewModel.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation
import UIKit
import Combine

class MeViewModel: ObservableObject {
    @Published var profilePicture: URL?
    @Published var name: String?
    @Published var dob: Date?
    @Published var gender: String?
    @Published var qrCodeImage = UIImage()
    @Published var selectedImages = [UIImage]()
    
    // For Editing
    @Published var nameValue = ""
    @Published var dobValue = Date.now
    @Published var genderValue = ""
    
    @Published var isShowingDialog = false
    @Published var showQRCodeDialog = false
    @Published var showPhotoPicker = false
    @Published var showActivityIndicator = false
    
    private var cancellables = [AnyCancellable]()
    private let meModel: MeModel = MeModelImpl.shared
    private let storageModel: StorageModel = StorageModelImpl.shared
    private let user: UserVO?
    
    init(user: UserVO?) {
        self.user = user
        profilePicture = user?.profilePicture
        name = user?.name
        dob = user?.dob
        gender = user?.gender
        
        if let qrCode = user?.qrCode {
            qrCodeImage = QRCodeGenerator.generateQRCode(from: qrCode)
        }
        
        nameValue = user?.name ?? ""
        dobValue = user?.dob ?? .now
        genderValue = user?.gender ?? ""
        
        $selectedImages.sink { [weak self] images in
            guard let user = user else {
                return
            }

            if let image = images.first,
               let data = image.pngData() {
                
                self?.showActivityIndicator = true
                self?.storageModel.uploadImage(imageData: data, to: profileImagesDir) { [weak self] url in
                    self?.meModel.changeProfilePicture(url: url, user: user) {
                        self?.profilePicture = url
                        self?.showActivityIndicator = false
                        self?.selectedImages = []
                    }
                }
            }
        }
        .store(in: &cancellables)
    }
    
    
    
    func onTapSave() {
        guard let user = user else {
            return
        }

        let updated = UserVO(name: nameValue,
                             dob: dobValue,
                             gender: genderValue,
                             profilePicture: user.profilePicture,
                             qrCode: user.qrCode,
                             password: user.password)
        
        showActivityIndicator = true
        meModel.updateInfo(with: updated) { [weak self] in
            guard let self = self else { return }
            
            self.showActivityIndicator = false
            self.name = self.nameValue
            self.dob = self.dobValue
            self.gender = self.genderValue
        }
    }
}
