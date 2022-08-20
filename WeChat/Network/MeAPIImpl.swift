//
//  MeAPIImpl.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation
import FirebaseFirestore

class MeAPIImpl: MeAPI {
    
    static let shared = MeAPIImpl()
    private init() { }
    
    private let db = Firestore.firestore()
    
    func changeProfilePicture(url: URL, user: UserVO, onSuccess: @escaping () -> Void) {
        let docRef = db.collection(usersCollection).document(user.qrCode)
        
        var userVO = user
        userVO.profilePicture = url
        
        try? docRef.setData(from: userVO) { error in
            if let error = error {
                print("Failed to change profile picture: \(error)")
                return
            } else {
                onSuccess()
            }
        }
    }
    
    func updateInfo(with newInfo: UserVO, onSuccess: @escaping () -> Void) {
        let docRef = db.collection(usersCollection).document(newInfo.qrCode)
        
        try? docRef.setData(from: newInfo) { error in
            if let error = error {
                print("Failed to update info: \(error)")
                return
            } else {
                onSuccess()
            }
        }
    }
}
