//
//  DateExtension.swift
//  WeChat
//
//  Created by kira on 20/08/2022.
//

import Foundation

extension Date {
    func toString() -> String {
        return ISO8601Format()
    }
    
    func toReadable() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: self)
    }
    
    static func create(from: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: from)!
        
        return date
    }
    
    func toDobFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    
    func formatForChatMessage() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: self)
    }
}
