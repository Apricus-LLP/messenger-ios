//
//  ForgetPasswordViewController.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 8/30/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    
    let vm = ResetPasswordViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        initVM()
    }
    
    private func initVM() {
        vm.showAlertClosure = { [weak self] in
            guard let self = self else { return }
            if self.vm.isSuccess {
                self.navigationController?.popToRootViewController(animated: true)
                AprSdkAlert.showAlert(at: self, title: self.vm.message!, message: "")
            } else {
                self.activityIndicator.stopAnimating()
                self.resetButton.isEnabled = true
                AprSdkAlert.showAlert(at: self, title: self.vm.message!, message: "")
            }
            
        }
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        activityIndicator.startAnimating()
        sender.isEnabled = false
        vm.resetPassword(email: emailTextField.text!)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupUI() {
        resetButton.layer.cornerRadius = 27.5
        emailTextField.layer.cornerRadius = 27.5
        
        emailTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        setupTextFields(textField: emailTextField)
        
        tapGesture.addTarget(self, action: #selector(dismissKeyboard))
    }
    
    func setupTextFields(textField: UITextField) {
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        textField.rightViewMode = .always
    }
}
