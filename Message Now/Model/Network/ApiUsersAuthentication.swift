//
//  ApiUsersAuthentication.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 4/22/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import Foundation

class ApiUsersAuthentication {
    
    public static let shared = ApiUsersAuthentication()
    
    public let ref = Database.database().reference()
    
    func ApuSignInUser(withEmail email: String, password: String, complation: @escaping(Bool, String?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                complation(false, error?.localizedDescription)
            } else {
                guard let user = result?.user else {
                    complation(false, "There was a problem, Thanks to try again")
                    return
                }
                UsersDatabase.shared.updateUserStatus(isOnline: true)
                UsersDatabase.shared.loadUserInfo(for: user.uid) { (user, error) in
                    guard let user = user else { return }
                    AprSdkDefaultSettings.shared.setUserDefauls(first: user.first, last: user.last, id: user.id, email: user.email, username: user.username, imageURL: user.imageURL, country: user.country)
                    complation(true, nil)
                }
            }
        }
    }
    
    func ApiSignUpUser(firstName: String, lasName: String, username: String, withEmail email: String, password: String, profileImage: UIImage?, complation: @escaping(Bool, String?) -> ()) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [unowned self] (result, error) in
            if error != nil {
                complation(false, error?.localizedDescription)
            } else {
                guard let ApiUser = result?.user else {
                    complation(false, "There was a problem, Thanks to try again")
                    return
                }
                
                self.ref.child("users").queryOrdered(byChild: "username").queryEqual(toValue: username).observeSingleEvent(of: .value) { [unowned self] (snapshot) in
                    if snapshot.exists() {
                        ApiUser.delete()
                        complation(false, "Sorry, The username is already exist")
                        return
                    } else {
                        guard let imageData = profileImage?.jpegData(compressionQuality: 0.5) else { return }
                        let uploadTask = Storage.storage().reference().child("profile").child("\(ApiUser.uid).jpg")
                        uploadTask.putData(imageData, metadata: nil) { (metaData, error) in
                            if error != nil {
                                ApiUser.delete()
                                complation(false, error?.localizedDescription)
                                return
                            } else {
                                uploadTask.downloadURL { [unowned self] (url, error) in
                                    if error != nil {
                                        uploadTask.delete(completion: nil)
                                        ApiUser.delete()
                                        complation(false, error?.localizedDescription)
                                    } else {
                                        let DBUser =
                                            ["first": firstName,
                                             "last": lasName,
                                             "username": username,
                                             "email": email,
                                             "id": ApiUser.uid,
                                             "imageULR": url?.absoluteString]
                                        self.ref.child("users").child(ApiUser.uid).setValue(DBUser) { (error, data) in
                                            if error != nil {
                                                ApiUser.delete()
                                                complation(false, "There was a problem, Thanks to try again")
                                            } else {
                                                AprSdkDefaultSettings.shared.setUserDefauls(first: firstName, last: lasName, id: ApiUser.uid, email: email, username: username, imageURL: url!.absoluteString, country: "")
                                                AprSdkDefaultSettings.shared.defaults.set(true, forKey: "status")
                                                complation(true, nil)
                                            }
                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func signOutUser(complation: @escaping(Bool, String?) -> ()) {
        do {
            UsersDatabase.shared.updateUserStatus(isOnline: false)
            ApiNetworkRequest.shared.frinedsList.removeAll()
            ApiNetworkRequest.shared.requestsRecived.removeAll()
            ApiNetworkRequest.shared.requestsSent.removeAll()
            try Auth.auth().signOut()
            complation(true, nil)
        } catch {
            complation(false, error.localizedDescription)
        }
    }
    
    func changePassword(password: String, complation: @escaping(Bool, String?) -> ()) {
        Auth.auth().currentUser?.updatePassword(to: password, completion: { (error) in
            error == nil ? complation(true, nil) : complation(false, error?.localizedDescription) })
    }
    
    func resetPassword(email: String, complation: @escaping(Bool, String?) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            error == nil ? complation(true, nil) : complation(false, error?.localizedDescription) }
    }
}
