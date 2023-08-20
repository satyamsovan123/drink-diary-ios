//
//  SignupViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        // performSegue(withIdentifier: "goToDataFromSignup", sender: self)
    }
}
