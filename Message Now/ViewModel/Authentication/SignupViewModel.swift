//
//  SignupViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 4/22/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class SignupViewModel {
    
    private var isSignupOurUser      : Bool? { didSet { signupClosure?() }}
    public  var messageAlert  : String? {  didSet { showAlertClosure?() }}
    
    var signupClosure   : (()->())?
    var showAlertClosure: (()->())?
    
    func signUpPressed(firstName: String, lasName: String, username: String, withEmail email: String, password: String, profileImage: UIImage?) {
        ApiUsersAuthentication.shared.ApiSignUpUser(firstName: firstName, lasName: lasName, username: username, withEmail: email, password: password, profileImage: profileImage) { [weak self] (isSuccess, error) in
            guard let self = self else { return }
            if !isSuccess {
                self.messageAlert = error
            } else {
                self.isSignupOurUser = isSuccess
            }
        }
    }
    
}
