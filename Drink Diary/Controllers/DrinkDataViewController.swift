//
//  ViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 19/08/23.
//

import UIKit

class DrinkDataViewController: UIViewController {

    var drinkDataManager = DrinkDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkDataManager.delegate = self
    }

    @IBOutlet weak var totalDrinksTextField: UITextField!
    
    @IBAction func decreasedPressed(_ sender: UIButton) {
    }
    

    @IBAction func increasedPressed(_ sender: UIButton) {
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        // performSegue(withIdentifier: "goToInformationFromDrinkData", sender: self)
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension DrinkDataViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}

// MARK: - DrinkDataManagerDelegate
extension DrinkDataViewController: DrinkDataManagerDelegate {
    
    func didUpdateData(_ drinkDataManager: DrinkDataManager, data: DrinkDataResponse) {
        
    }
    
    func didFailWithError(error: Error) {
        print("Error in drink data - \(error)")
    }
    
}
