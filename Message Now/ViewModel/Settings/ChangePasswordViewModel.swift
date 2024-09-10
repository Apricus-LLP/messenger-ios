//
//  ChangePassword.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/20/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class ChangePasswordViewModel {
    
    var message = String() { didSet { changePasswordClosure?() }}
    
    var changePasswordClosure: (()->())?
    
    func chnagePassword(password: String, repassword: String) {
        if password == repassword {
            ApiUsersAuthentication.shared.changePassword(password: password) { [weak self] (isSuccess, error) in
                guard let self = self else { return }
                self.message = isSuccess ? "Password Updated" : error!
            }
        } else {
            message = "The Password and Re-password not similar"
        }
    }
    
}
