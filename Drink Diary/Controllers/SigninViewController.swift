//
//  SigninViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import UIKit

class SigninViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        performSegue(withIdentifier: "goToDataFromSignin", sender: self)
    }
}
