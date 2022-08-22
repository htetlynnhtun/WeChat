//
//  StorageAPIImpl.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation
import FirebaseStorage

class StorageAPIImpl: StorageAPI {
    
    static let shared = StorageAPIImpl()
    private init() { }
    
    private let storage = Storage.storage()
    
    func uploadImage(imageData: Data, to dir: String, completion: @escaping (URL) -> Void) {
        let ref = storage.reference()
        let imageRef = ref.child("\(dir)/\(UUID().uuidString).jpg")
        
        imageRef.putData(imageData) { result in
            switch result {
            case .success(_):
                imageRef.downloadURL { result in
                    switch result {
                    case .success(let url):
                        completion(url)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func uploadAudio(audioData: Data, completion: @escaping (URL) -> Void) {
        let ref = storage.reference()
        let audioRef = ref.child("audioFiles/\(UUID().uuidString).m4a")
        
        audioRef.putData(audioData) { result in
            switch result {
            case .success(_):
                audioRef.downloadURL { result in
                    switch result {
                    case .success(let url):
                        completion(url)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
