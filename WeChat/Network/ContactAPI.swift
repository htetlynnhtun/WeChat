//
//  ContactAPI.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation

protocol ContactAPI {
    func addContact(qrCode: String, to user: UserVO, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func getContacts(for user: UserVO, onDataArrived: @escaping ([UserVO]) -> Void)
    func getGroups(for user: UserVO, onDataArrived: @escaping ([GroupVO]) -> Void)
    func createGroup(with users: [UserVO], name: String, onSuccess: @escaping () -> Void)
}
