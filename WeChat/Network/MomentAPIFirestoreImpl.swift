//
//  MomentAPIFirestoreImpl.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation
import FirebaseFirestore

class MomentAPIFirestoreImpl: MomentAPI {
    
    static let shared = MomentAPIFirestoreImpl()
    private init() { }
    
    private let db = Firestore.firestore()
    
    func createMoment(payload: MomentVO, compleiton: @escaping (Result<Any, CMomentError>) -> Void) {
        do {
            let _ = try db.collection(momentsCollection).addDocument(from: payload)
            compleiton(.success(true))
        } catch {
            compleiton(.failure(.unexpected))
        }
    }
    
    func getMoments(onSuccess: @escaping ([MomentVO]) -> Void) {
        db.collection(momentsCollection).addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Failed to fetch moments")
                return
            }
            
            let moments: [MomentVO] = documents.compactMap { documentSnapshot in
                let result = Result { try documentSnapshot.data(as: MomentVO.self) }
                
                switch result {
                case .success(let moment):
                    return moment
                case .failure(_):
                    print("Failed to decode Moment")
                    return nil
                }
            }
            onSuccess(moments)
        }
    }
    
    func likeMoment(moment: MomentVO, user: UserVO) {
        let docRef = db.collection(momentsCollection).document(moment.id!)
        var momentVO = moment
        
        momentVO.likes.append(user)
        try? docRef.setData(from: momentVO)
    }
    
    func unlikeMoment(moment: MomentVO, user: UserVO) {
        let docRef = db.collection(momentsCollection).document(moment.id!)
        var momentVO = moment
        
        if let i = moment.likes.firstIndex(where: { userVO in
            userVO.qrCode == user.qrCode
        }) {
            momentVO.likes.remove(at: i)
            try? docRef.setData(from: momentVO)
        }
    }
    
    func bookmarkMoment(moment: MomentVO, user: UserVO) {
        let docRef = db.collection(momentsCollection).document(moment.id!)
        var momentVO = moment
        
        momentVO.bookmarks.append(user)
        try? docRef.setData(from: momentVO)
    }
    
    func unbookmarkMoment(moment: MomentVO, user: UserVO) {
        let docRef = db.collection(momentsCollection).document(moment.id!)
        var momentVO = moment
        
        if let i = moment.bookmarks.firstIndex(where: { userVO in
            userVO.qrCode == user.qrCode
        }) {
            momentVO.bookmarks.remove(at: i)
            try? docRef.setData(from: momentVO)
        }
    }
}
