//
//  User.swift
//  Friend
//
//  Created by Олексій Якимчук on 06.08.2023.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int16
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    var formattedRegister: Date {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: registered) ?? Date.now
    }
}
