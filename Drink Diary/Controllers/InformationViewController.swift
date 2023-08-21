//
//  InformationViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 21/08/23.
//

import UIKit

class InformationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
