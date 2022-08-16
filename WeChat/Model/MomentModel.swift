//
//  MomentModel.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation

protocol MomentModel {
    func createMoment(payload: MomentVO, compleiton: @escaping (Result<Any, CMomentError>) -> Void)
    func getMoments(onSuccess: @escaping ([MomentVO]) -> Void)
    func likeMoment(moment: MomentVO, user: UserVO)
    func unlikeMoment(moment: MomentVO, user: UserVO)
    func bookmarkMoment(moment: MomentVO, user: UserVO)
    func unbookmarkMoment(moment: MomentVO, user: UserVO)
}

class MomentModelImpl: MomentModel {
    
    static let shared = MomentModelImpl()
    private init() { }
    
    private let api: MomentAPI = MomentAPIFirestoreImpl.shared
    
    func createMoment(payload: MomentVO, compleiton: @escaping (Result<Any, CMomentError>) -> Void) {
        api.createMoment(payload: payload, compleiton: compleiton)
    }
    
    func getMoments(onSuccess: @escaping ([MomentVO]) -> Void) {
        api.getMoments { moments in
            let sorted = moments.sorted { a, b in
                a.createdAt.compare(b.createdAt) == .orderedDescending
            }
            onSuccess(sorted)
        }
    }
    
    func likeMoment(moment: MomentVO, user: UserVO) {
        api.likeMoment(moment: moment, user: user)
    }
    
    func unlikeMoment(moment: MomentVO, user: UserVO) {
        api.unlikeMoment(moment: moment, user: user)
    }
    
    func bookmarkMoment(moment: MomentVO, user: UserVO) {
        api.bookmarkMoment(moment: moment, user: user)
    }
    
    func unbookmarkMoment(moment: MomentVO, user: UserVO) {
        api.unbookmarkMoment(moment: moment, user: user)
    }
}
