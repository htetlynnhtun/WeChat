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
}
