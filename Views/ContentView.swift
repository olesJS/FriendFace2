//
//  ContentView.swift
//  Friend
//
//  Created by Олексій Якимчук on 06.08.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var cachedUsers: FetchedResults<CachedUser>
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            VStack {
                List(cachedUsers, id: \.self) { user in
                    NavigationLink {
                        UserView(user: user, friends: user.friendsArray)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.title3).bold()
                                Text(user.wrappedEmail)
                            }
                            
                            Spacer()
                            
                            HStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(user.isActive ? .green : .gray)
                                Text(user.isActive ? "Online" : "Offline")
                            }
                        }
                    }
                }
                Button("Save") {
                    loadDataToCoreData()
                }
            }
            .navigationTitle("FriendFace")
        }
        .task {
            await loadData()
            loadDataToCoreData()
        }
    }
    
    // Getting data from JSON URL
    func loadData() async {
        if let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                  do {
                      users = try JSONDecoder().decode([User].self, from: data)
                  } catch let error {
                     print(error)
                  }
               }
           }.resume()
        }
    }
    
    func loadDataToCoreData() {
        do {
            for user in users {
                let newUser = CachedUser(context: moc)
                newUser.id = user.id
                newUser.name = user.name
                newUser.isActive = user.isActive
                newUser.age = user.age
                newUser.company = user.company
                newUser.email = user.email
                newUser.address = user.address
                newUser.about = user.about
                newUser.registered = user.formattedRegister
                newUser.tags = user.tags.joined(separator: ",")
                
                var friendArray = [CachedFriend]()
                
                for friend in user.friends {
                    let newFriend = CachedFriend(context: moc)
                    newFriend.name = friend.name
                    newFriend.id = friend.id
                    friendArray.append(newFriend)
                }
                
                newUser.addToFriends(NSSet(array: friendArray))
            }
            try moc.save()
            print("MOC saved")
        } catch {
            print("Error saving Core Data context: \(error)")
        }
    }
}

