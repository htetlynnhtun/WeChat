//
//  ChatAPI.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation

protocol ChatAPI {
    func sendP2PMessage(from sender: UserVO, to receiver: UserVO, message: MessageVO)
    func getMessagesBetween(_ user: UserVO, and other: UserVO, onDataArrived: @escaping ([MessageVO]) -> Void)
}
