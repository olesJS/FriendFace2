//
//  UserView.swift
//  Friend
//
//  Created by Олексій Якимчук on 07.08.2023.
//

import SwiftUI

struct UserView: View {
    let user: CachedUser
    let friends: [CachedFriend]
    
    var body: some View {
        ScrollView {
            HStack {
                Image(systemName: "person.circle")
                    .font(.largeTitle).foregroundColor(user.isActive ? .green : .gray)
                Text(user.wrappedName)
                    .font(.title).bold()
            }
            
            VStack {
                Text("\(user.age) y.o.")
                    .font(.title3)
                Text(user.wrappedAddress)
                    .font(.title3)
                Text("In FriendFace since \(user.wrappedRegistered)")
                    .font(.title3)
            }
            
            VStack(alignment: .leading) {
                Text("About me:")
                    .font(.title3).bold()
                Text(user.wrappedAbout)
            }
            .padding()
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            
            VStack(alignment: .leading) {
                Text("\(user.friendsArray.count) friends")
                    .font(.title3).bold()
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(friends) { friend in
                            HStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.blue).font(.title2)
                                Text(friend.wrappedName)
                                    .font(.title3)
                            }
                            .padding()
                            .background(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("User View")
        .navigationBarTitleDisplayMode(.inline)
    }
}
