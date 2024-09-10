//
//  AprSdkActivityIndecator.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/7/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit


struct AprSdkActivityIndicator {
    
    private static let activityIndicator = UIActivityIndicatorView()
    
    public static func initActivityIndecator(view: UIView) {
        activityIndicator.color = UIColor(named: "ActivityIndecatorColor")
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
    }
    
    public static func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    public static func stopAnimating() {
        activityIndicator.stopAnimating()
    }
    
}

