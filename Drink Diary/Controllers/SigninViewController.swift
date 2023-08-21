//
//  SigninViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import UIKit

class SigninViewController: UIViewController {
    
    var authenticationManager = AuthenticationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        authenticationManager.delegate = self
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signupPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignupFromSignin", sender: self)
    }
    
    @IBAction func helpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHelpFromSignin", sender: self)
    }
    
    @IBAction func signinPressed(_ sender: UIButton) {
        // performSegue(withIdentifier: "goToDrinkDataFromSignin", sender: self)
        // performSegue(withIdentifier: "goToInformationFromSignin", sender: self)
        print(emailTextField.text)
        print(passwordTextField.text)
    }
    
}

// MARK: - UITextFieldDelegate
extension SigninViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(emailTextField.text)
        print(passwordTextField.text)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
}

// MARK: - AuthenticationManagerDelegate
extension SigninViewController: AuthenticationManagerDelegate {
    
    func didUpdateData(_ authenticationManager: AuthenticationManager, data: AuthenticationResponse) {
        
    }
    
    func didFailWithError(error: Error) {
        print("Error in sign in - \(error)")
    }
    
    func didReceiveToken(token: String) {
        
    }
    
}
