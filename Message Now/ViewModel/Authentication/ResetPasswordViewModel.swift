//
//  ResetPasswordViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/1/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class ResetPasswordViewModel {
    
    var message     : String? { didSet { showAlertClosure?() }}
    
    var isSuccess   = true

    var showAlertClosure: (()->())?
    
    func resetPassword(email: String) {
        ApiUsersAuthentication.shared.resetPassword(email: email) { (isSuccess, error) in
            if isSuccess {
                self.isSuccess = isSuccess
                self.message   = "We sent an email to reset your password, Thanks to check your email"
            } else {
                self.isSuccess = isSuccess
                self.message   = error
            }
        }
    }
}



