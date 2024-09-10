//
//  AprSdkAlert.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 4/21/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

struct AprSdkAlert {
    
    static func showAlert(at viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
}
