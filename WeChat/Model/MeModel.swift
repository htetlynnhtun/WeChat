//
//  MeModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation

protocol MeModel {
    func changeProfilePicture(url: URL, user: UserVO, onSuccess: @escaping () -> Void)
}

class MeModelImpl: MeModel {
    
    static let shared = MeModelImpl()
    private init() { }
    
    private let api: MeAPI = MeAPIImpl.shared
    
    func changeProfilePicture(url: URL, user: UserVO, onSuccess: @escaping () -> Void) {
        api.changeProfilePicture(url: url, user: user, onSuccess: onSuccess)
    }
}
