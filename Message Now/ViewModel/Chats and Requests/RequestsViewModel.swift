//
//  RequestsViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/9/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class RequestsViewModel {
    
    private var recivedViewModel = [UserViewModel]()
    private var sentViewModel    = [UserViewModel]()
    public  var userViewModel    = [UserViewModel]() { didSet { reloadTableView?() }}
    
    public  var numberOfCells: Int { return userViewModel.count }
    
    public  var reloadTableView: (()->())?
    
    func initFetch() {
        if ApiNetworkRequest.shared.requestsRecived.isEmpty {
            ApiNetworkRequest.shared.checkRequestsRecived { (_) in
                ApiNetworkRequest.shared.loadUsersOfRequests(requestType: .recived) { [weak self] (requests) in
                    guard let self = self else { return }
                    guard let requests = requests else {
                        self.selectedSegmentIndex(SegmentIndex: 0)
                        return
                    }
                    self.createRecivedViewModel(users: requests)
                    self.selectedSegmentIndex(SegmentIndex: 0)
                }
            }
        } else {
            ApiNetworkRequest.shared.loadUsersOfRequests(requestType: .recived) { [weak self] (requests) in
                guard let self = self else { return }
                self.createRecivedViewModel(users: requests!)
                self.selectedSegmentIndex(SegmentIndex: 0)
            }
        }
        
        if ApiNetworkRequest.shared.requestsSent.isEmpty {
            ApiNetworkRequest.shared.checkRequestsSent { (_) in
                ApiNetworkRequest.shared.loadUsersOfRequests(requestType: .sent) { [weak self] (requests) in
                    guard let self = self else { return }
                    guard let requests = requests else { return }
                    self.createSentViewModel(users: requests)
                }
            }
        } else {
            ApiNetworkRequest.shared.loadUsersOfRequests(requestType: .sent) { [weak self] (requests) in
                guard let self = self else { return }
                self.createSentViewModel(users: requests!)
            }
        }
    }
    
    private func createRecivedViewModel(users: [User]) {
        var vms = [UserViewModel]()
        for user in users {
            vms.append(proccessFetchUsers(user: user))
        }
        recivedViewModel.append(contentsOf: vms)
    }
    
    private func createSentViewModel(users: [User]) {
        var vms = [UserViewModel]()
        for user in users {
            vms.append(proccessFetchUsers(user: user))
        }
        sentViewModel.append(contentsOf: vms)
    }
    
    private func proccessFetchUsers(user: User) -> UserViewModel {
        let name = user.first! + " " + user.last!
        return UserViewModel(name: name, username: user.username!, imageURL: user.imageURL!, uid: user.id!)
    }
    
    func selectedSegmentIndex(SegmentIndex: Int) {
        switch SegmentIndex {
            case 1:
            userViewModel = sentViewModel
            default:
            userViewModel = recivedViewModel
        }
    }
    
    func confirmRequest(uid: String) {
        ApiNetworkRequest.shared.confirmRequestFriend(uid: uid)
    }
    
    func declineRequest(uid: String) {
        ApiNetworkRequest.shared.declineRequestFriend(uid: uid)
    }
    
    func removeRequest(uid: String) {
        ApiNetworkRequest.shared.cancelRequestFriend(uid: uid)
    }
}

