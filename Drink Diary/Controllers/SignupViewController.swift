//
//  SignupViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import UIKit

class SignupViewController: UIViewController {
    var email = ""
    var password = ""
    var token = ""
    var message = ""
    let action = "signup"
    
    var authenticationManager = AuthenticationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        authenticationManager.delegate = self
    }
    
    @IBOutlet weak var mainView: UIStackView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signinPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSigninFromSignup", sender: self)
    }
    
    @IBAction func helpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHelpFromSignup", sender: self)
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        email = emailTextField.text!
        password = passwordTextField.text!
        authenticate(email: email, password: password)
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        
    }
    
    func authenticate(email: String, password: String) {
        if(email == "" || password == "") {
            return
        }
        
        activityIndicator.startAnimating()
        mainView.alpha = 0.5
        mainView.isUserInteractionEnabled = false
        
        let authenticationRequest = AuthenticationRequest(email: email, password: password)
        authenticationManager.performBackendRequest(authenticationRequest: authenticationRequest, action: action)
    }
    
    func stopProcessing() {
        self.activityIndicator.stopAnimating()
        self.mainView.alpha = 1
        self.mainView.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToDrinkDataFromSignup") {
            let destinationViewController = segue.destination as! DrinkDataViewController
            destinationViewController.token = token
        } else if(segue.identifier == "goToInformationFromSignup") {
            let destinationViewController = segue.destination as! InformationViewController
            destinationViewController.message = message
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.placeholder! == "john@appleseed.com" && textField.text != "") {
            email = textField.text!
            emailTextField.endEditing(true)
        } else if(textField.placeholder! == "password" && textField.text != "") {
            password = textField.text!
            passwordTextField.endEditing(true)
        }
        // authenticate(email: email, password: password)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.placeholder! == "john@appleseed.com" && textField.text != "") {
            email = textField.text!
            emailTextField.endEditing(true)
        } else if(textField.placeholder! == "password" && textField.text != "") {
            password = textField.text!
            passwordTextField.endEditing(true)
        }
        return true
    }
}

// MARK: - AuthenticationManagerDelegate
extension SignupViewController: AuthenticationManagerDelegate {
    func didCompleteAuthentication(_ authenticationManager: AuthenticationManager, authenticationResponse: AuthenticationResponse) {
        DispatchQueue.main.async {
            self.stopProcessing()
            
            self.message = authenticationResponse.message
            CommonService.logger("Message - \(self.message)")
            if(self.message != Constant.AuthenticationMessage.signupSuccessfulMessage) {
                self.performSegue(withIdentifier: "goToInformationFromSignup", sender: self)
            }
        }
    }
    
    func didFailWithError(error: Error) {
        CommonService.logger("Error in sign up - \(error)")
        DispatchQueue.main.async {
            self.stopProcessing()
            
            self.message = Constant.Common.error
            self.performSegue(withIdentifier: "goToInformationFromSignup", sender: self)
        }
    }
    
    func didReceiveToken(_ authenticationManager: AuthenticationManager, token: String) {
        DispatchQueue.main.async {
            self.stopProcessing()
            
            self.token = token
            CommonService.logger("Token - \(self.token)")
            if(token != "") {
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegue(withIdentifier: "goToDrinkDataFromSignup", sender: self)
            }
        }
    }
}
