//
//  MockDataViewModel.swift
//  WeChat
//
//  Created by kira on 18/07/2022.
//

import Foundation

final class MockDataViewModel: ObservableObject {
    @Published var images = ["moment-pic-3"]
//    @Published var images = ["moment-pic-3", "moment-pic-2", "moment-pic-1"]
    @Published var moments: [MomentVOD] = load("moments.json")
    @Published var messages: [MessageVOD] = load("messages.json")
    @Published var users: [UserVOD] = load("users.json")
    @Published var currentUser = UserVOD(
        id: 777,
        name: "John",
        avatar: "https://i.pravatar.cc/150?u=a042581f4e29026704d",
        favorites: [105, 102],
        contacts: [101, 102, 103, 104, 105]
    )
}

func load<T: Decodable>(_ filename: String) -> T {
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    let data: Data
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self)\n\(error)")
    }
}
