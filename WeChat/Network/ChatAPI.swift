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
    func sendGroupMessage(to groupID: String, message: MessageVO)
    func getGroupMessages(for groupID: String, onDataArrived: @escaping ([MessageVO]) -> Void)
    func getLatestMessages(for user: String, onDataArrived: @escaping ([MessageVO]) -> Void)
    func getLatestGroupMessages(for user: String, onDataArrived: @escaping ([MessageVO]) -> Void)
}
