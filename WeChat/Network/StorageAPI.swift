//
//  StorageAPI.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation

protocol StorageAPI {
    func uploadImage(imageData: Data, completion: @escaping (URL) -> Void)
}
