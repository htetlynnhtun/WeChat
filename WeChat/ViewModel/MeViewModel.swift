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
    @Published var nameValue = ""
    @Published var phoneValue = ""
    @Published var dobValue = Date.now
    @Published var genderValue = ""
    @Published var selectedImages = [UIImage]()
    @Published var qrCodeImage = UIImage()
    
    @Published var isShowingDialog = false
    @Published var showQRCodeDialog = false
    @Published var showPhotoPicker = false
    @Published var showActivityIndicator = false
    
    private var cancellables = [AnyCancellable]()
    private let meModel: MeModel = MeModelImpl.shared
    private let storageModel: StorageModel = StorageModelImpl.shared
    
    
    init(user: UserVO) {
        nameValue = user.name
        phoneValue = user.qrCode
        // dob - String to Date
        genderValue = user.gender
        
        qrCodeImage = QRCodeGenerator.generateQRCode(from: user.qrCode)
        
        $selectedImages.sink { [weak self] images in
            if let image = images.first,
               let data = image.pngData() {
                
                self?.showActivityIndicator = true
                self?.storageModel.uploadImage(imageData: data) { [weak self] url in
                    self?.meModel.changeProfilePicture(url: url, user: user) {
                        self?.showActivityIndicator = false
                        self?.selectedImages = []
                    }
                }
            }
        }
        .store(in: &cancellables)
    }
    
    
    
    func onTapSave() {
        print("About to save")
        print("name: \(nameValue)")
        print("phone: \(phoneValue)")
        print("dob: \(dobValue)")
        print("gender: \(genderValue)")
    }
}
