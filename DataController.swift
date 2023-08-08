//
//  DataController.swift
//  Friend
//
//  Created by Олексій Якимчук on 07.08.2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "FriendApp")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("CoreData failed to load \(error.localizedDescription)")
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
