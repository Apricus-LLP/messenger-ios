//
//  SignupViewController.swift
//  SmartTalk MVP
//
//  Created by Pavel Mac on 6/22/24.
//  Copyright © 2024 Apricus-LLP. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    private let vm    = SignupViewModel()
    private var image = UIImage() { didSet { profileImage.setImage(image, for: .normal) } }
    
    @IBOutlet weak var profileImage: UIButton!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var lastTextfield: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var haveAccountButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCellUI()
        initVM()
    }
    
    private func initVM() {
        vm.signupClosure = { [weak self] () in
            guard let self = self else { return }
            self.presentViewController()
        }
        
        vm.showAlertClosure = { [weak self] () in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.signUpButton.isEnabled = true
            AprSdkAlert.showAlert(at: self, title: "Sign Up Validation", message: self.vm.messageAlert!)
        }
    }
    
    private func presentViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "tabBar")
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true)
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        dismissKeyboard()
        activityIndicator.startAnimating()
        signUpButton.isEnabled = false
        vm.signUpPressed(firstName: "1s", lasName: "1s", username: "1s", withEmail: emailTextfield.text!, password: passwordTextfield.text!, profileImage: profileImage.currentImage!)
        //vm.signUpPressed(firstName: firstTextField.text ?? "1s", lasName: lastTextfield.text ?? "1s", username: usernameTextField.text ?? "1s", withEmail: emailTextfield.text!, password: passwordTextfield.text!, profileImage: profileImage.currentImage!)
    }
    
    @IBAction func haveAccountPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func profileImagePressed(_ sender: Any) {
        SystemAuthorization.shared.photoAuthorization { [weak self] (isAuth, message) in
            guard let self = self else { return }
            if isAuth {
                self.imagePressed()
            } else {
                DispatchQueue.main.async {
                    AprSdkAlert.showAlert(at: self, title: "Photo Library", message: message!)
                }
            }
        }
    }
    

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupCellUI() {
        //Setup cornerRadius
        profileImage.layer.cornerRadius = 60
        profileImage.layer.masksToBounds = true
        firstTextField.layer.cornerRadius = 27.5
        lastTextfield.layer.cornerRadius = 27.5
        usernameTextField.layer.cornerRadius = 27.5
        emailTextfield.layer.cornerRadius = 27.5
        passwordTextfield.layer.cornerRadius = 27.5
        signUpButton.layer.cornerRadius = 27.5
        haveAccountButton.layer.cornerRadius = 27.5
        
        firstTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        lastTextfield.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        usernameTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        emailTextfield.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        passwordTextfield.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        haveAccountButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        setupTextFields(textField: firstTextField)
        setupTextFields(textField: lastTextfield)
        setupTextFields(textField: usernameTextField)
        setupTextFields(textField: emailTextfield)
        setupTextFields(textField: passwordTextfield)
        
        tapGesture.addTarget(self, action: #selector(dismissKeyboard))
        
        activityIndicator.stopAnimating()
    }
    
    func setupTextFields(textField: UITextField) {
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: textField.frame.height))
        textField.rightViewMode = .always
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func imagePressed() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}
