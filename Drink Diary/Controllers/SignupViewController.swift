//
//  SignupViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import UIKit

class SignupViewController: UIViewController {
    
    var authenticationManager = AuthenticationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        authenticationManager.delegate = self
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signinPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSigninFromSignup", sender: self)
    }
    
    @IBAction func helpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToHelpFromSignup", sender: self)
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        // performSegue(withIdentifier: "goToDrinkDataFromSignup", sender: self)
        // performSegue(withIdentifier: "goToInformationFromSignup", sender: self)
        print(emailTextField.text)
        print(passwordTextField.text)
    }
    
}

// MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {
    
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
extension SignupViewController: AuthenticationManagerDelegate {
    
    func didUpdateData(_ authenticationManager: AuthenticationManager, data: AuthenticationResponse) {
        
    }
    
    func didFailWithError(error: Error) {
        print("Error in sign up - \(error)")
    }
    
    func didReceiveToken(token: String) {
        
    }
    
}
