//
//  BlockedViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/25/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class BlockedViewModel {
    
    var userViewModel = [UserViewModel]() { didSet { reloadTableViewClouser?() }}
    var numberOfCells : Int? { return userViewModel.count}
    
    var reloadTableViewClouser: (()->())?
    
    func initFetch() {
        if ApiNetworkRequest.shared.blockedList.isEmpty {
            ApiNetworkRequest.shared.fetchBlockedList { (_) in
                ApiNetworkRequest.shared.fetchBlockedUsers { [weak self] (users) in
                    guard let self = self else { return }
                    guard let users = users else { return }
                    self.createUserViewModel(users: users)
                }
            }
        } else {
            ApiNetworkRequest.shared.fetchBlockedUsers { [weak self] (users) in
                guard let self = self else { return }
                self.createUserViewModel(users: users!)
            }
        }
    }
    
    private func createUserViewModel(users: [User]) {
        var vms = [UserViewModel]()
        for user in users {
            vms.append(proccessFetchUsers(user: user))
        }
        userViewModel.append(contentsOf: vms)
    }
    
    private func proccessFetchUsers(user: User) -> UserViewModel {
        let name = user.first! + " " + user.last!
        return UserViewModel(name: name, username: user.username!, imageURL: user.imageURL!, uid: user.id!)
    }
    
    func unblockUser(uid: String) {
        ApiNetworkRequest.shared.unblockUser(uid: uid)
    }
    
}
