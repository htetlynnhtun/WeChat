//
//  ContactAPIImpl.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseDatabase

class ContactAPIImpl: ContactAPI {
    
    static let shared = ContactAPIImpl()
    private init() { }
    
    private let db = Firestore.firestore()
    private let ref = Database.database().reference();
    
    func addContact(qrCode: String, to user: UserVO, onSuccess: @escaping () -> Void, onFailure: @escaping (String) -> Void) {
        let userDocRef = db.collection(usersCollection).document(user.qrCode)
        let beingAddedDocRef =  db.collection(usersCollection).document(qrCode)
        /// Contacts of user
        let contactsSubcollection1 = userDocRef.collection(contactsSubCollection)
        /// Contacts of beingAdded
        let contactsSubcollection2 = beingAddedDocRef.collection(contactsSubCollection)
        
        beingAddedDocRef.getDocument(as: UserVO.self) { result in
            switch result {
            case .success(let beingAddedUser):
                let subDocRef = contactsSubcollection1.document(beingAddedUser.qrCode)
                
                subDocRef.getDocument { documentSnapshot, error in
                    guard error == nil else {
                        onFailure("Failed to add contact: \(error!.localizedDescription)")
                        return
                    }
                    
                    if let documentSnapshot = documentSnapshot {
                        if (documentSnapshot.exists) {
                            onFailure("This user is already in your contact")
                        } else {
                            try? subDocRef.setData(from: beingAddedUser) { error in
                                guard error == nil else {
                                    onFailure("Failed to add contact: \(error!.localizedDescription)")
                                    return
                                }
                                
                                try? contactsSubcollection2.document(user.qrCode).setData(from: user) { error in
                                    guard error == nil else {
                                        onFailure("Failed to add contact: \(error!.localizedDescription)")
                                        return
                                    }
                                    
                                    onSuccess()
                                }
                                
                            }
                        }
                    }
                }
                
                
            case .failure(_):
                onFailure("User not found")
            }
        }
    }
    
    func getContacts(for user: UserVO, onDataArrived: @escaping ([UserVO]) -> Void) {
        let contactsCollectionRef = db.collection(usersCollection).document(user.qrCode).collection("contacts")
        
        contactsCollectionRef.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Failed to fetch contacts")
                return
            }
            
            let contacts: [UserVO] = documents.compactMap { documentSnapshot in
                let result = Result { try documentSnapshot.data(as: UserVO.self) }
                
                switch result {
                case .success(let user):
                    return user
                case .failure(_):
                    return nil
                }
            }
            
            onDataArrived(contacts)
        }
    }
    
    func getGroups(for user: UserVO, onDataArrived: @escaping ([GroupVO]) -> Void) {
        let groupsCollectionRef = db.collection(usersCollection).document(user.qrCode).collection(groupsSubCollection)
        
        groupsCollectionRef.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("Failed to fetch groups")
                return
            }
            
            let groups: [GroupVO] = documents.compactMap { documentSnapshot in
                let result = Result { try documentSnapshot.data(as: GroupVO.self) }
                
                switch result {
                case .success(let group):
                    return group
                case .failure(_):
                    return nil
                }
            }
            
            onDataArrived(groups)
        }
    }
    
    func createGroup(with users: [UserVO], name: String, onSuccess: @escaping () -> Void) {
        // create a group node in realtimedb
        let groupID = UUID().uuidString
        ref
            .child(groupsNode)
            .child(groupID)
            .setValue([
                "name": name
            ])
        
        let group = DispatchGroup()
        // put the created group under each user's groups sub-collection in firestore
        users.forEach { user in
            group.enter()
            let groupDocRef = db.collection(usersCollection).document(user.qrCode).collection(groupsSubCollection).document(groupID)
            
            try? groupDocRef.setData(from: GroupVO(id: groupID, name: name)) { error in
                if let error = error {
                    print("Failed to add the created group to user: \(user.qrCode), error: \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            onSuccess()
        }
        
        
    }
}
