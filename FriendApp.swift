//
//  FriendApp.swift
//  Friend
//
//  Created by Олексій Якимчук on 06.08.2023.
//

import SwiftUI

@main
struct FriendApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
