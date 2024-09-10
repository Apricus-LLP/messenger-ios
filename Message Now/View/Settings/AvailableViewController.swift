//
//  AvailableViewController.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/29/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class AvailableViewController: UIViewController {
    
    let defaults = AprSdkDefaultSettings.shared.defaults
    
    @IBOutlet weak var statusSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let status = defaults.bool(forKey: "status")
        statusSwitch.isOn = status
    }
    
    @IBAction func switchPressed(_ sender: UISwitch) {
        let database = UsersDatabase.shared
        let status = sender.isOn
        defaults.set(status, forKey: "status")
        status ? database.updateUserStatus(isOnline: status) : database.updateUserStatus(isOnline: status)
    }
    
    

}
