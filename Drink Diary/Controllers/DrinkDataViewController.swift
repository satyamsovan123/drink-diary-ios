//
//  ViewController.swift
//  Drink Diary
//
//  Created by Satyam Sovan Mishra on 19/08/23.
//

import UIKit

// MARK: - DrinkDataViewController
class DrinkDataViewController: UIViewController {
    var token = ""
    var message = ""
    var beverageName = ""
    var totalDrinks = ""
    
    var drinkDataManager = DrinkDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drinkDataManager.delegate = self
        beverageNameTextField.delegate = self
        totalDrinksTextField.delegate = self
        
       getData()
    
    }
    
    @IBOutlet weak var beverageNameTextField: UITextField!
    
    @IBOutlet weak var mainView: UIStackView!
    
    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var totalDrinksTextField: UITextField!
    
    @IBAction func decreasedPressed(_ sender: UIButton) {
        if let safeCurrentTotalDrinksString = totalDrinksTextField.text {
            if let safeCurrentTotalDrinksInt = Int(safeCurrentTotalDrinksString) {
                if(safeCurrentTotalDrinksInt > 0) {
                    totalDrinksTextField.text = String(safeCurrentTotalDrinksInt - 1)
                }
            }
        }
    }
    
    @IBAction func increasedPressed(_ sender: UIButton) {
        if let safeCurrentTotalDrinksString = totalDrinksTextField.text {
            if let safeCurrentTotalDrinksInt = Int(safeCurrentTotalDrinksString) {
                    totalDrinksTextField.text = String(safeCurrentTotalDrinksInt + 1)
            }
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        totalDrinks = totalDrinksTextField.text!
        beverageName = beverageNameTextField.text!
                
        updateData(totalDrinks: totalDrinks, beverageName: beverageName)
        totalDrinksTextField.endEditing(true)
        beverageNameTextField.endEditing(true)
        // performSegue(withIdentifier: "goToInformationFromDrinkData", sender: self)
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        self.token = ""
        setBackground(beverageName: "")
        self.dismiss(animated: true, completion: nil)
    }
    
    func stopProcessing() {
        self.activityIndicator.stopAnimating()
        self.mainView.alpha = 1
        self.mainView.isUserInteractionEnabled = true
    }
    
    func startProcessing() {
        activityIndicator.startAnimating()
        mainView.alpha = 0.5
        mainView.isUserInteractionEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToInformationFromDrinkData") {
            let destinationViewController = segue.destination as! InformationViewController
            destinationViewController.message = message
        }
    }
}

// MARK: - Get and set data
extension DrinkDataViewController {
    func getData() {
        startProcessing()
        drinkDataManager.getDrinkData(token: self.token)
    }
    
    func setData(totalDrinks: Int, beverageName: String) {
        totalDrinksTextField.text = String(totalDrinks)
        beverageNameTextField.text = beverageName
        setBackground(beverageName: beverageName)
    }
    
    func setBackground(beverageName: String) {
        CommonService.getBackground(beverageName)
        background.image = UIImage(named: CommonService.currentBackground)
    }
}

// MARK: - Update data
extension DrinkDataViewController {
    func updateData(totalDrinks: String, beverageName: String) {
        if(totalDrinks == "" || beverageName == "") {
            return
        }
                
        startProcessing()
        let totalDrinksInt = Int(totalDrinks) ?? 0
        let drinkDataRequest = DrinkDataRequest(totalDrinks: totalDrinksInt, beverageName: beverageName)
        drinkDataManager.updateDrinkData(drinkDataRequest: drinkDataRequest, token: self.token)
    }
}

// MARK: - UITextFieldDelegate
extension DrinkDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.placeholder! == "0" && textField.text != "") {
            totalDrinks = textField.text!
            totalDrinksTextField.endEditing(true)
        } else if(textField.placeholder! == "Water" && textField.text != "") {
            beverageName = textField.text!
            setBackground(beverageName: beverageName)
            beverageNameTextField.endEditing(true)
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField.placeholder! == "0" && textField.text != "") {
            totalDrinks = textField.text!
            totalDrinksTextField.endEditing(true)
        } else if(textField.placeholder! == "Water" && textField.text != "") {
            beverageName = textField.text!
            setBackground(beverageName: beverageName)
            beverageNameTextField.endEditing(true)
        }
        return true
    }
}

// MARK: - DrinkDataManagerDelegate
extension DrinkDataViewController: DrinkDataManagerDelegate {
    func didUpdateDrinkData(_ drinkDataManager: DrinkDataManager, drinkDataResponse: DrinkDataResponse) {
        DispatchQueue.main.async {
            self.stopProcessing()
            
            self.message = drinkDataResponse.message
            CommonService.logger("Message - \(self.message)")
            
            self.performSegue(withIdentifier: "goToInformationFromDrinkData", sender: self)
        }
    }
    
    func didReceiveDrinkData(_ drinkDataManager: DrinkDataManager, drinkDataResponse: DrinkDataResponse) {
        DispatchQueue.main.async {
            self.stopProcessing()
            
            self.message = drinkDataResponse.message
            CommonService.logger("Message - \(self.message)")
            
            if(self.message != Constant.DrinkDataMessage.drinkDataReceivedSuccessfulMessage) {
                self.performSegue(withIdentifier: "goToInformationFromDrinkData", sender: self)
            }
            
            self.setData(totalDrinks: drinkDataResponse.data.totalDrinks ?? 0, beverageName: drinkDataResponse.data.beverageName ?? "")
        }
    }
    
    func didFailWithError(error: Error) {
        CommonService.logger("Error in data - \(error)")
        DispatchQueue.main.async {
            self.stopProcessing()
            
            self.message = Constant.Common.error
            self.performSegue(withIdentifier: "goToInformationFromDrinkData", sender: self)
        }
    }
}
