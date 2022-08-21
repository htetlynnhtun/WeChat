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
    @Published var showActivityIndicator = false
    
    /// Total contacts
    @Published var contacts = [String: [UserVO]]()
    @Published var searchKeyword = ""
    
    /// For creating a new group
    @Published var groupName = ""
    /// For creating a new group
    @Published var selectedUsers = [UserVO]()
    @Published var showAddNewGroup = false
    @Published var groups = [GroupVO]()
    
    @Published var originalContacts = [UserVO]()
    
    private let currentUser: UserVO
    private var cancellables = [AnyCancellable]()
    private let contactModel: ContactModel = ContactModelImpl.shared
    
    init(user: UserVO) {
        currentUser = user
        
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
    
    func fetchContacts() {
        contactModel.getContacts(for: self.currentUser) { [weak self] contacts in
            guard let self = self else { return }
            
            self.originalContacts = contacts
        }
    }
    
    func fetchGroups() {
        contactModel.getGroups(for: self.currentUser) { [weak self] groups in
            guard let self = self else { return }
            
            self.groups = groups
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
    
    // MARK: - UI Events
    
    func addContact(qrCode: String, onDone: @escaping () -> Void) {
        contactModel.addContact(qrCode: qrCode, to: currentUser) {
            onDone()
        } onFailure: { [weak self] msg in
            self?.toastMessage = msg
            self?.showToastMessage = true
            onDone()
        }
    }
    
    func createNewGroup() {
        guard groupName.isNotEmpty,
              !selectedUsers.isEmpty else {
            return
        }
        
        var totalUsers = [currentUser]
        totalUsers.append(contentsOf: selectedUsers)
        
        showActivityIndicator = true
        contactModel.createGroup(with: totalUsers, name: groupName) { [weak self] in
            guard let self = self else { return }
            
            self.showActivityIndicator = false
            self.selectedUsers = []
            self.groupName = ""
            self.showAddNewGroup = false
        }
    }
    
    func onTapSelect(_ user: UserVO) {
        if let i = selectedUsers.firstIndex(of: user) {
            // user is already selected, so remove it
            selectedUsers.remove(at: i)
        } else {
            // user is not selected, so add it
            selectedUsers.append(user)
        }
    }
    
    func onTapAddNewGroup() {
        showAddNewGroup = true
    }
    
    func onDismissAddNewGroup() {
        showAddNewGroup = false
        selectedUsers = []
    }
    
    // MARK: - Helpers
    
    func isSelected(_ user: UserVO) -> Bool {
        return selectedUsers.contains(user)
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
