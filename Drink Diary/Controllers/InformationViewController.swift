//
//  InformationViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 21/08/23.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var background: UIImageView!
    
    var message = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = message
        background.image = UIImage(named: CommonService.currentBackground)
    }

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
