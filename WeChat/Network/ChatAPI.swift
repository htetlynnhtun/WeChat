//
//  ChatAPI.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation

protocol ChatAPI {
    func sendP2PMessage(from sender: String, to receiver: String, message: MessageVO)
    func getMessagesBetween(_ user: String, and other: String, onDataArrived: @escaping ([MessageVO]) -> Void)
}
