//
//  ChatAPIImpl.swift
//  WeChat
//
//  Created by kira on 17/08/2022.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore
import Combine

class ChatAPIImpl: ChatAPI {
    
    static let shared = ChatAPIImpl()
    private init() { }
    
    private let ref = Database.database().reference()
    private let db = Firestore.firestore()
    
    func sendP2PMessage(from sender: String, to receiver: String, message: MessageVO) {
        // for sender
        ref
            .child(messagesNode)
            .child(sender)
            .child(receiver)
            .child(message.id)
            .setValue(message.toAny())
        
        // for receiver
        ref
            .child(messagesNode)
            .child(receiver)
            .child(sender)
            .child(message.id)
            .setValue(message.toAny())
        
    }
    
    func getMessagesBetween(_ user: String, and other: String, onDataArrived: @escaping ([MessageVO]) -> Void) {
        ref
            .child(messagesNode)
            .child(user)
            .child(other)
            .observe(.value) { snapshot in
                var messages = [MessageVO]()
                
                snapshot.children.forEach { value in
                    let singleSnapshot = value as! DataSnapshot
                    messages.append(.init(from: singleSnapshot))
                }
                
                onDataArrived(messages)
            }
    }
    
    func sendGroupMessage(to groupID: String, message: MessageVO) {
        ref
            .child(groupsNode)
            .child(groupID)
            .child(groupMessages)
            .child(message.id)
            .setValue(message.toAny())
    }
    
    func getGroupMessages(for groupID: String, onDataArrived: @escaping ([MessageVO]) -> Void) {
        ref
            .child(groupsNode)
            .child(groupID)
            .child(groupMessages)
            .observe(.value) { snapshot in
                var messages = [MessageVO]()
                
                snapshot.children.forEach { value in
                    let singleSnapshot = value as! DataSnapshot
                    messages.append(.init(from: singleSnapshot))
                }
                
                onDataArrived(messages)
            }
    }
    
    func getLatestMessages(for user: String, onDataArrived: @escaping ([MessageVO]) -> Void) {
        ref
            .child(messagesNode)
            .child(user)
            .observe(.value) { contacts in
                var messages = [MessageVO]()
                
                contacts.children.forEach { contact in
                    let contactSnapshot = contact as! DataSnapshot
                    var messagesForThisContact = [MessageVO]()
                    
                    contactSnapshot.children.forEach { message in
                        let messageSnapshot = message as! DataSnapshot
                        messagesForThisContact.append(.init(from: messageSnapshot))
                    }
                    
                    let sorted = messagesForThisContact.sorted { a, b in
                        a.timestamp.compare(b.timestamp) == .orderedAscending
                    }
                    
                    if let lastMessage = sorted.last {
                        messages.append(lastMessage)
                    }
                }
                
                let sorted = messages.sorted { a, b in
                    a.timestamp.compare(b.timestamp) == .orderedDescending
                }
                
                onDataArrived(sorted)
            }
    }
    
    func getLatestGroupMessages(for user: String, onDataArrived: @escaping ([MessageVO]) -> Void) {
        let groupsRef = db.collection(usersCollection).document(user).collection(groupsSubCollection)
        
        groupsRef.addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            guard let documents = snapshot?.documents else { return }
            
            let groups: [GroupVO] = documents.compactMap { documentSnapshot in
                let result = Result { try documentSnapshot.data(as: GroupVO.self) }
                
                switch result {
                case .success(let groupVO):
                    return groupVO
                    
                case .failure(_):
                    return nil
                }
            }
            let dispatchGroup = DispatchGroup()
            var allLatest = [MessageVO]()
            
            groups.forEach { group in
                dispatchGroup.enter()
                
                self.ref
                    .child(groupsNode)
                    .child(group.id)
                    .child(groupMessages)
                    .observe(.value) { snapshot in
                        
                        var messagesForThisGroup = [MessageVO]()
                        
                        snapshot.children.forEach { message in
                            let messageSnapshot = message as! DataSnapshot
                            
                            messagesForThisGroup.append(.init(from: messageSnapshot))
                        }
                        
                        let sorted = messagesForThisGroup.sorted { a, b in
                            a.timestamp.compare(b.timestamp) == .orderedAscending
                        }
                        
                        if let lastMessage = sorted.last {
                            allLatest.append(lastMessage)
                        }
                        
                        dispatchGroup.leave()
                    }
            }
            
            dispatchGroup.notify(queue: .main) {
                onDataArrived(allLatest)
            }
        }
        
    }
}
