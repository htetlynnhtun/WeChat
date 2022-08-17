//
//  MeAPI.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation

protocol MeAPI {
    func changeProfilePicture(url: URL, user: UserVO, onSuccess: @escaping () -> Void)
}
