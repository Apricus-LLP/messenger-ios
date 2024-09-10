//
//  SignInViewModel.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/23/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class SignInViewModel {
    
    private var isSignIn: Bool? { didSet { signInClosure?() }}
    public  var message : String? { didSet { showAlertClosure?() }}
    
    var signInClosure: (()->())?
    var showAlertClosure: (()->())?
    
    func signInPressed(withEmail email: String, password: String) {
        ApiUsersAuthentication.shared.ApuSignInUser(withEmail: email, password: password) { [weak self] (isSuccess, error) in
            guard let self = self else { return }
            if !isSuccess {
                self.message = error
            } else {
                self.isSignIn = isSuccess
            }
        }
    }
    
}
