//
//  Friend.swift
//  Friend
//
//  Created by Олексій Якимчук on 06.08.2023.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
