//
//  HelpViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 20/08/23.
//

import UIKit


class HelpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        helpLabel.text = Constant.Common.helpLabel
    }
    
    @IBOutlet weak var helpLabel: UILabel!
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteAccountPressed(_ sender: UIButton) {
        // performSegue(withIdentifier: "goToInformationFromSignup", sender: self)
    }
}
