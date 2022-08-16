//
//  CredntialsRepository.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation

protocol CredentialsRepository {
    func saveCredentials(vo: UserVO, completion: @escaping () -> Void)
    func clearCredentials(completion: @escaping () -> Void)
    func getCredentials(completion: @escaping (UserVO?) -> Void)
}
