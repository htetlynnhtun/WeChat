//
//  MomentAPI.swift
//  WeChat
//
//  Created by kira on 16/08/2022.
//

import Foundation

protocol MomentAPI {
    func createMoment(payload: MomentVO, compleiton: @escaping (Result<Any, CMomentError>) -> Void)
    func getMoments(onSuccess: @escaping ([MomentVO]) -> Void)
    func likeMoment(moment: MomentVO, user: UserVO)
    func unlikeMoment(moment: MomentVO, user: UserVO)
    func bookmarkMoment(moment: MomentVO, user: UserVO)
    func unbookmarkMoment(moment: MomentVO, user: UserVO)
}

enum CMomentError: Error {
    case unexpected
    
    var message: String {
        return "Failed to create moment"
    }
}
