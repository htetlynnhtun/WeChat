//
//  ContactsViewModel.swift
//  WeChat
//
//  Created by kira on 24/07/2022.
//

import Foundation
import Combine

class ContactsViewModel: ObservableObject {
    var currentUser: UserVOD
    var searchValueSubject = PassthroughSubject<String, Never>()
    
    required init(currentUser: UserVOD) {
        self.currentUser = currentUser
    }
    
    static func forPreivew() -> ContactsViewModel {
        return self.init(currentUser: MockDataViewModel().currentUser)
    }
    
    var favorites: [UserVOD] {
        get {
            return MockDataViewModel().users.filter { value in
                return currentUser.favorites.contains { value.id == $0 }
            }
        }
    }
    
    var contacts: [String: [UserVOD]] {
        var results: [String: [UserVOD]] = .init()
        let sorted = MockDataViewModel().users
            .sorted { a, b in
                a.name.compare(b.name) == .orderedAscending
            }
        
        sorted.forEach { value in
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
