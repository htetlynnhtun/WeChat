//
//  ContactModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation

protocol ContactModel {
    func addContact(qrCode: String, to user: UserVO, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void)
    func getContacts(for user: UserVO, onDataArrived: @escaping ([UserVO]) -> Void)
}

class ContactModelImpl: ContactModel {
    
    static let shared = ContactModelImpl()
    private init() { }
    
    private let api: ContactAPI = ContactAPIImpl.shared
    
    func addContact(qrCode: String, to user: UserVO, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        api.addContact(qrCode: qrCode, to: user, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getContacts(for user: UserVO, onDataArrived: @escaping ([UserVO]) -> Void) {
        api.getContacts(for: user) { contacts in
            let sorted = contacts.sorted { a, b in
                a.name.compare(b.name) == .orderedAscending
            }
            
            onDataArrived(sorted)
        }
    }
}
