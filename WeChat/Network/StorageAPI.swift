//
//  StorageAPI.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation

protocol StorageAPI {
    func uploadImage(imageData: Data, to dir: String, completion: @escaping (URL) -> Void)
    func uploadImage(imageData: Data, to dir: String, fileExtension: String, completion: @escaping (URL) -> Void)
    func uploadAudio(audioData: Data, completion: @escaping (URL) -> Void)
}
