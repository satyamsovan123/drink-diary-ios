//
//  ViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 19/08/23.
//

import UIKit

class DrinkDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var totalDrinksTextField: UITextField!
    
    @IBAction func decreasedPressed(_ sender: UIButton) {
    }
    

    @IBAction func increasedPressed(_ sender: UIButton) {
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        // performSegue(withIdentifier: "", sender: self)
        self.dismiss(animated: true, completion: nil)
    }

}

