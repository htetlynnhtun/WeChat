//
//  CredentialsRepositoryJSONImpl.swift
//  WeChat
//
//  Created by kira on 15/08/2022.
//

import Foundation

class CredentialsRepositoryJSONImpl: CredentialsRepository {
    
    static let shared = CredentialsRepositoryJSONImpl()
    private init() {}
    
    private let appSuppDir = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    
    func saveCredentials(vo: UserVO, completion: @escaping () -> Void) {
        let credentialsURL = appSuppDir!.appendingPathComponent("credentials.json")
        
        do {
            try JSONEncoder().encode(vo).write(to: credentialsURL)
            completion()
        } catch {
            print("Failed to save credentials: \(error.localizedDescription)")
        }
    }
    
    func clearCredentials(completion: @escaping () -> Void) {
        let credentialsURL = appSuppDir!.appendingPathComponent("credentials.json")
        do {
            try FileManager.default.removeItem(at: credentialsURL)
            completion()
        } catch {
            print("Failed to logout")
        }
    }
    
    func getCredentials(completion: @escaping (UserVO?) -> Void) {
        let credentialsURL = appSuppDir!.appendingPathComponent("credentials.json")
        
        do {
            let user = try JSONDecoder().decode(UserVO.self, from: Data(contentsOf: credentialsURL))
            completion(user)
        } catch {
            print("Can't get credentials: \(error.localizedDescription)")
            completion(nil)
        }
    }
}
