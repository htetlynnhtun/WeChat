//
//  StorageModel.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation

protocol StorageModel {
    func uploadImage(imageData: Data, completion: @escaping (URL) -> Void)
}

class StorageModelImpl: StorageModel {
    
    static let shared = StorageModelImpl()
    private init() { }
    
    private let api: StorageAPI = StorageAPIImpl.shared
    
    func uploadImage(imageData: Data, completion: @escaping (URL) -> Void) {
        api.uploadImage(imageData: imageData, completion: completion)
    }
}
