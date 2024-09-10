//
//  PhotoDetailViewController.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/12/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    var photoURL = String()
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.KFloadImage(url: photoURL)
        swipeGesture.direction = .down
        swipeGesture.addTarget(self, action: #selector(dismissSdkRounterVC))
    }

    @objc func dismissSdkRounterVC() {
        dismiss(animated: true)
    }
}
