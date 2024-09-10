//
//  EditeProfileViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/23/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class EditeProfileViewModel {

    var userInfo: UserInfoViewModel? { didSet {loadUserInfoClosure?() }}
    var message : String? { didSet { showAlertClosure?() }}
    
    var loadUserInfoClosure: (()->())?
    var showAlertClosure   : (()->())?
    
    func initFetch() {
        AprSdkDefaultSettings.shared.initUserDefaults { [unowned self] (user) in
            self.userInfo = self.proccessCreateUser(user: user)
        }
    }
    
    func UpdateProfile(photo: UIImage, country: String) {
        UsersDatabase.shared.editeProfile(profileImage: photo, country: country) { [unowned self] (isSuccess, error) in
            self.message = isSuccess ?  "Profile Updated Successfully" : error
        }
    }
    
    private func proccessCreateUser(user: User) -> UserInfoViewModel{
        let country = user.country == "" ? "Kazakhstan" : user.country
        return UserInfoViewModel(photo: user.image, country: country)
    }
}

struct UserInfoViewModel {
    var photo  : UIImage?
    var country: String?
}
