//
//  AboutViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/25/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class AboutViewModel {
    
    public var userViewModel   = UserViewModel() { didSet { reloadTableViewClosure?() }}
    public var isBlocked       = false           { didSet { reloadTableViewClosure?() }}
    public var message         : String?         { didSet { showAlertClosure?() }}
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure      : (()->())?
    
    func initFetch(uid: String) {
        UsersDatabase.shared.loadUserInfo(for: uid) { [weak self] (user, error) in
            guard let self = self else { return }
            if error == nil {
                self.userViewModel = self.proccessFetchUser(user: user!)
            } else { self.message = error! }
        }
    }
    
    private func proccessFetchUser(user: User) -> UserViewModel {
        let name = user.first! + " " + user.last!
        let status = ApiNetworkRequest.shared.blockedList.contains(user.id!) ? false : user.isOnline
        return UserViewModel(name: name, username: user.username, email: user.email, imageURL: user.imageURL, uid: user.id, isOnline: status, country: user.country)
    }
    
    func checkBlocking(uid: String) {
        if ApiNetworkRequest.shared.blockedList.isEmpty {
            ApiNetworkRequest.shared.fetchBlockedList { [weak self] (_) in
                guard let self = self else { return }
                self.isBlocked = ApiNetworkRequest.shared.blockedList.contains(uid)
            }
        } else {
            self.isBlocked = ApiNetworkRequest.shared.blockedList.contains(uid)
        }
    }
    
    func blockUser(uid: String) {
        ApiNetworkRequest.shared.blockUser(uid: uid)
        self.isBlocked = true
    }
    
    func unblockUser(uid: String) {
        ApiNetworkRequest.shared.unblockUser(uid: uid)
        self.isBlocked = false
    }
}
