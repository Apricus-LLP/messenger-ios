//
//  SettingsViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/23/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class SettingsViewModel {
    
    let defaults = UserDefaults.standard
    var user = User() {
        didSet {
            loadInfoClosure?()
        }
    }
    
    var loadInfoClosure: (()->())?
    
    func loadInfo() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if self.defaults.string(forKey: "id") == uid  {
            AprSdkDefaultSettings.shared.initUserDefaults { (user) in
                self.user = user
            }
        } else {
            UsersDatabase.shared.loadUserInfo(for: uid) { [weak self] (user, error) in
                guard let self = self else { return }
                if error != nil {
                    print(error!)
                } else {
                    guard let user = user else { return }
                    self.user = user
                    AprSdkDefaultSettings.shared.setUserDefauls(first: user.first, last: user.last, id: user.id, email: user.email, username: user.username, imageURL: user.imageURL, country: user.country)
                }
            }
        }
    }
}
