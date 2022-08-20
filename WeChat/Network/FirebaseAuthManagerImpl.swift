//
//  FirebaseAuthManagerImpl.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation
import FirebaseFirestore
import BCryptSwift

class FirebaseAuthManagerImpl: AuthManager {
    
    let db = Firestore.firestore()
    
    func getOTP(phone: String, completion: @escaping (Result<Bool, OTPError>) -> Void) {
        let docRef = db.collection("users").document(phone)
        
        docRef.getDocument { document, error in
            guard error == nil else {
                completion(.failure(.unexpected))
                return
            }
            
            if let document = document,
               document.exists {
                completion(.failure(.userExist))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func verifyOTP(otp: String, completion: @escaping (Bool) -> Void) {
        let docRef = db.collection("otp").document("default")
        
        docRef.getDocument { document, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(false)
                return
            }
            
            if let document = document {
                let code = document.get("code") as! String
                completion(otp == code)
            } else {
                completion(false)
            }
        }
    }
    
    func signUp(phone: String, name: String, dob: Date, gender: String, password: String, completion: @escaping (Bool) -> Void) {
        let docRef = db.collection("users").document(phone)
        
        DispatchQueue.global(qos: .background).async {
            let salt = BCryptSwift.generateSalt()
            if let hash = BCryptSwift.hashPassword(password, withSalt: salt) {
                
                DispatchQueue.main.async {
                    let userVO = UserVO(id: phone, name: name, dob: dob, gender: gender, profilePicture: URL(string: "https://i.pravatar.cc/300")!, qrCode: phone, password: hash)
                    do {
                        try docRef.setData(from: userVO) { error in
                            guard error == nil else {
                                completion(false)
                                return
                            }
                            
                            completion(true)
                        }
                    } catch {
                        completion(false)
                    }
                    //                    docRef.setData([
                    //                        "phoneNumber": phone,
                    //                        "name": name,
                    //                        "dob": dob,
                    //                        "gender": gender,
                    //                        "profilePicture": "",
                    //                        "qrCode": "\(phone)-\(UUID().uuidString)",
                    //                        "password": hash
                    //                    ]) { error in
                    //                        guard error == nil else {
                    //                            completion(false)
                    //                            return
                    //                        }
                    //
                    //                        completion(true)
                    //                    }
                }
                
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    
    func login(phone: String, password: String, completion: @escaping (Result<UserVO, LoginError>) -> Void) {
        let docRef = db.collection("users").document(phone)
        
        docRef.getDocument(as: UserVO.self) { result in
            switch result {
            case .success(let userVO):
                if let result = BCryptSwift.verifyPassword(password, matchesHash: userVO.password) {
                    if result {
                        completion(.success(userVO))
                    } else {
                        completion(.failure(.invalid))
                    }
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(_):
                completion(.failure(.unexpected))
            }
        }
        
        //        docRef.getDocument { document, error in
        //            guard error == nil else {
        //                completion(.failure(.unexpected))
        //                return
        //            }
        //
        //            if let document = document,
        //               document.exists {
        //                do {
        //                    let jsonData = try JSONSerialization.data(withJSONObject: document.data()!)
        //                    let userVO = try JSONDecoder().decode(UserVO.self, from: jsonData)
        //
        //                    if let result = BCryptSwift.verifyPassword(password, matchesHash: userVO.password) {
        //                        if result {
        //                            completion(.success(userVO))
        //                        } else {
        //                            completion(.failure(.invalid))
        //                        }
        //                    } else {
        //                        completion(.failure(.unexpected))
        //                    }
        //                } catch {
        //                    completion(.failure(.unexpected))
        //                }
        //
        //            } else {
        //                completion(.failure(.invalid))
        //            }
        //        }
    }
}
