//
//  PeopleViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 4/24/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation


class PeopleViewModel{
    
    var friendViewModel     = [UserViewModel]() { didSet { reloadTableViewClosure?() } }
    var selectedCell        : UserViewModel?
    var numberOfCells       : Int { return friendViewModel.count }
    
    var originalModel       = [UserViewModel]()
    var numbserOfSections   = 0
    
    var titlesOfSection: [String] {
        switch numbserOfSections {
        case 1: return ["friends"]
        case 2: return ["search", "friends"]
        default: return [String]()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    
    func initFetch() {
        ApiNetworkRequest.shared.loadFriendsList { (_) in
            ApiNetworkRequest.shared.loadFriends { [weak self] (users) in
                guard let self = self else { return }
                self.numbserOfSections = 1
                guard let users = users else {
                    self.reloadTableViewClosure?()
                    return
                }
                self.friendViewModel.removeAll()
                self.createUserViewModel(users: users)
            }
        }
    }
    
    private func createUserViewModel(users: [User]) {
        var vms = [UserViewModel]()
        for user in users {
            vms.append(proccessFetchUsers(user: user))
        }
        friendViewModel.append(contentsOf: vms)
    }
    
    private func proccessFetchUsers(user: User) -> UserViewModel {
        let name = user.first! + " " + user.last!
        return UserViewModel(name: name, username: user.username!, email: user.email!, imageURL: user.imageURL!, uid: user.id!)
    }
    
    func getCellViewModel(at indexpath: IndexPath) -> UserViewModel{
        return friendViewModel[indexpath.row]
    }
    
    func pressedCell(at indexpath: IndexPath) {
        selectedCell = friendViewModel[indexpath.row]
    }
    
    func startSearching() {
        originalModel = friendViewModel
    }
    
    func searchAbout(text: String) {
        if text.isEmpty {
            friendViewModel = originalModel
        } else {
            let text = text.lowercased()
            friendViewModel = originalModel.filter() {($0.name?.lowercased().contains((text)))!}
        }
    }
    
    func endSearching() {
        friendViewModel = originalModel
    }
}

struct UserViewModel{
    var name     : String?
    var username : String?
    var email    : String?
    var imageURL : String?
    var uid      : String?
    var status   : String?
    var isOnline : Bool?
    var country  : String?
}
