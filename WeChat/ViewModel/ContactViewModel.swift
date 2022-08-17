//
//  ContactViewModel.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import Combine

class ContactViewModel: ObservableObject {
    
    @Published var toastMessage = ""
    @Published var showToastMessage = false
    @Published var contacts = [String: [UserVO]]()
    @Published private var originalContacts = [UserVO]()
    @Published var searchKeyword = ""
    
    private let currentUser: UserVO
    private var cancellables = [AnyCancellable]()
    private let contactModel: ContactModel = ContactModelImpl.shared
    
    init(user: UserVO) {
        currentUser = user
        
        fetchContacts()
        
        $originalContacts.sink { [weak self] contacts in
            guard let self = self else { return }
            
            self.contacts = self.mapContactsArrToDict(contacts: contacts)
        }
        .store(in: &cancellables)
        
        $searchKeyword.sink { [weak self] keyword in
            guard let self = self else { return }
            
            if keyword.isEmpty {
                self.contacts = self.mapContactsArrToDict(contacts: self.originalContacts)
            } else {
                let matchedContacts = self.originalContacts.filter { contact in
                    let anyMatch = contact.name.lowercased().range(of: keyword.lowercased())
                    
                    return anyMatch == nil ? false : true
                }
                
                self.contacts = self.mapContactsArrToDict(contacts: matchedContacts)
            }
        }
        .store(in: &cancellables)
    }
    
    private func fetchContacts() {
        contactModel.getContacts(for: self.currentUser) { [weak self] contacts in
            guard let self = self else { return }
            
            self.originalContacts = contacts
        }
    }
    
    private func mapContactsArrToDict(contacts: [UserVO]) -> [String: [UserVO]] {
        var results: [String: [UserVO]] = .init()
        
        contacts.forEach { value in
            let char = String(value.name.first!)
            if var arr = results[char] {
                arr.append(value)
                results[char] = arr
            } else {
                results[char] = [value]
            }
        }
        return results
    }
    
    
    func addContact(qrCode: String, onDone: @escaping () -> Void) {
        contactModel.addContact(qrCode: qrCode, to: currentUser) {
            onDone()
        } onFailure: { [weak self] msg in
            self?.toastMessage = msg
            self?.showToastMessage = true
            onDone()
        }
    }
    
    let alphabets = [
        "A",
        "B",
        "C",
        "D",
        "E",
        "F",
        "G",
        "H",
        "I",
        "J",
        "K",
        "L",
        "M",
        "N",
        "O",
        "P",
        "Q",
        "R",
        "S",
        "T",
        "U",
        "V",
        "W",
        "X",
        "Y",
        "Z",
    ]
}
